use llvm_plugin::inkwell::basic_block::{self, BasicBlock};
use llvm_plugin::inkwell::module::Module;
use llvm_plugin::{
    LlvmModulePass, ModuleAnalysisManager, PassBuilder, PipelineParsing, PreservedAnalyses,
};
use lock_detection::reentrant_lock_detection::{UseVar, Next};
use lock_detection::reentrant_lock_detection::{
    self, 
    facts::Extendable,
    Lock, Release, Def
};
use std::borrow::BorrowMut;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use llvm_plugin::inkwell::values::{InstructionValue, InstructionOpcode, AsValueRef, BasicValue};
use llvm_plugin::utils::InstructionIterator;
use crate::util::llvm_ir::{
    KnownCallsites, InstructionCallSites, Predecessors, KnowAlloca, Var
};

#[llvm_plugin::plugin(name = "reentrant_lock_detection", version = "0.1")]
fn plugin_registrar(builder: &mut PassBuilder) {

    builder.add_module_pipeline_parsing_callback(|name, manager| {
        if name == "reentrant-lock-detection" {

            manager.add_pass(ReentrantLockPass::default());

        
            PipelineParsing::Parsed
        } else {
       
            PipelineParsing::NotParsed
        }
    });
}

#[derive(Debug, Clone, Hash, PartialEq, Eq)]
pub struct Symbol(pub String);

#[derive(Debug, Clone)]
pub struct MayAliasTable(HashMap<Symbol, Symbol>);

impl MayAliasTable {
    pub fn new() -> Self {
        Self(HashMap::new())
    }

    pub fn insert(&mut self, key: Symbol, value: Symbol) {
        self.0.insert(key, value);
    }

    pub fn get(&self, key: &Symbol) -> Option<&Symbol> {
        self.0.get(key)
    }

    pub fn get_root_symbol(&self, key: &Symbol) -> Symbol {
        let mut current = key;
        while let Some(next) = self.get(current) {
            if next == current {
                break;
            }
            current = next;
        }
        current.clone()
    }

}


#[derive(Debug, Clone)]
struct ReentrantLockPass {
    // interior mutability on reentrant lock detection Program
    pub program: RefCell<reentrant_lock_detection::Program<Symbol>>,

    pub may_alias_table: RefCell<MayAliasTable>,
}

impl Default for ReentrantLockPass {
    fn default() -> Self {
        Self {
            program: RefCell::new(reentrant_lock_detection::Program::new()),
            may_alias_table: RefCell::new(MayAliasTable::new())
        }
    }
}

impl ReentrantLockPass {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn handle_alias_instructions(&self, inst : InstructionValue) {
        match inst.get_opcode() {
            InstructionOpcode::Call | InstructionOpcode::Invoke => {
                match KnownCallsites::from_instr(&inst) {
                    KnownCallsites::StdSyncMutexLock => {
                        self.handle_std_sync_mutex_lock_alias(inst);
                    },
                    _ => {

                    }
                }
            },
            InstructionOpcode::Alloca => {
                self.handle_alloca_inst(inst);
            },
            _ => {

            }
        }
    }

    pub fn handle_instruction(&self, inst : InstructionValue) {

        for predecessor in Predecessors::get_predecessors(inst) {
            let mut program = self.program.borrow_mut();
            program.extend(vec![
                Next(
                    Symbol(format!("{:?}", predecessor)),
                    Symbol(format!("{:?}", inst))
                )
            ]);
        }
        
        match inst.get_opcode() {
            InstructionOpcode::Call  | InstructionOpcode::Invoke => { // we don't care about error handling, so these can be the same thing
               self.handle_call_inst(inst);
            },
            _ => {
               
            }
        }

    }

    fn handle_alloca_inst(&self, inst : InstructionValue) {

        match KnowAlloca::from_instr(&inst) {
            KnowAlloca::MutexGuard => {
                // ! look at this hack
                // ! if we have this mutex guard allocation site
                // ! we can assume that the next instruction is the guard label that will actually be used
                // ! we the lock gets dropped.
                let next_inst = inst.get_next_instruction()
                .expect("if there's a mutex guard allocation, there should be a next instruction");
    
                let next_inst_sym = Symbol(
                    Var::get_var_name_from_instr(&next_inst)
                );

                let this_symbol = Symbol(
                    Var::get_var_name_from_instr(&inst)
                );

                let mut may_alias_table = self.may_alias_table.borrow_mut();
                may_alias_table.insert(next_inst_sym, this_symbol);

            },
            _ => {

            }
        }
    }

    fn handle_call_inst(&self, inst : InstructionValue) {
       // 
       match InstructionCallSites::demangled_called_function_name(&inst) {
           Ok(_) => {
               match KnownCallsites::from_instr(&inst) {
                   KnownCallsites::StdSyncMutexLock => {
                        self.handle_std_sync_mutex_lock(inst);
                   },
                   KnownCallsites::StdSyncMutexNew => {
                        self.handle_std_sync_mutex_new(inst);
                   },
                   KnownCallsites::StdSyncMutexDrop => {
                        self.handle_std_sync_mutex_drop(inst);
                   },
                   KnownCallsites::Unknown => {
                       // println!("Unknown");
                   }
                   
               }
           },
           Err(e) => {
               // println!("Error: {}", e);
           }
           
       }

    }

    fn handle_std_sync_mutex_lock_alias(&self, inst : InstructionValue) {

        let var_basic_value = inst.get_operand(1)
        .expect("Lock should have a 0th operand for the lock name")
        .expect_left("Lock 0th operand should be a basic value.");
        let var = Var::get_var_name_from_basic_value(
            &var_basic_value
        );


        let alias_basic_value = inst.get_operand(0)
        .expect("Lock should have a 0th operand for the guard alias")
        .expect_left("Lock should be a basic value.");
        let alias = Var::get_var_name_from_basic_value(
            &alias_basic_value
        );

        let var_sym = Symbol(var);
        let alias_sym = Symbol(alias);
    
        // insert the guard  alias into the table
        let mut may_alias_table = self.may_alias_table.borrow_mut();
        may_alias_table.insert(alias_sym, var_sym.clone());

    }

    fn handle_std_sync_mutex_lock(&self, inst : InstructionValue) {

        let var_basic_value = inst.get_operand(1)
        .expect("Lock should have a 0th operand for the lock name")
        .expect_left("Lock 0th operand should be a basic value.");
        let var = Var::get_var_name_from_basic_value(
            &var_basic_value
        );


        let alias_basic_value = inst.get_operand(0)
        .expect("Lock should have a 0th operand for the guard alias")
        .expect_left("Lock should be a basic value.");
        let alias = Var::get_var_name_from_basic_value(
            &alias_basic_value
        );

        let var_sym = Symbol(var);
        let alias_sym = Symbol(alias);
        let inst_sym = Symbol(format!("{:?}", inst));

        let mut program = self.program.borrow_mut();

        program.extend(vec![
            Def(
                var_sym.clone(),
                inst_sym.clone()
            )
        ]);
        
        program.extend(vec![
            UseVar(
                var_sym.clone(),
                inst_sym.clone()
            )
        ]);

        program.extend(vec![
            Lock(
                inst_sym.clone(),
                var_sym.clone()
            )
        ]);

    }

    fn handle_std_sync_mutex_new(&self, inst : InstructionValue) {

        let mut program = self.program.borrow_mut();

        // Add a def expression to indicate that the lock is created
        let var_basic_value = inst.get_operand(0)
        .expect("Lock should have a 0th operand for the lock name")
        .expect_left("Lock 0th operand should be a basic value.");
        let var = Var::get_var_name_from_basic_value(
            &var_basic_value
        );

        let var_sym = Symbol(var);
        let inst_sym = Symbol(format!("{:?}", inst));

        program.extend(vec![
            Def(var_sym.clone(), inst_sym.clone()),
        ]);

        program.extend(vec![
            UseVar(var_sym.clone(), inst_sym.clone()),
        ]);

    }

    fn handle_std_sync_mutex_drop(&self, inst : InstructionValue) {

        let var_basic_value = inst.get_operand(0)
        .expect("Lock should have a 0th operand for the lock being dropped")
        .expect_left("Lock 0th operand should be a basic value.");
        let var = Var::get_var_name_from_basic_value(
            &var_basic_value
        );


        let alias_sym = Symbol(var);
        let inst_sym = Symbol(format!("{:?}", inst));

        let may_alias_table = self.may_alias_table.borrow();
        let root_sym = may_alias_table.get_root_symbol(&alias_sym);

        let mut program = self.program.borrow_mut();

        program.extend(vec![
            Def(
                root_sym.clone(),
                inst_sym.clone()
            )
        ]);

        program.extend(vec![
            UseVar(
                root_sym.clone(),
                inst_sym.clone()
            )
        ]);

        program.extend(vec![
            Release(
                inst_sym.clone(),
                root_sym.clone()
            )
        ]);
        
    }

}

impl LlvmModulePass for ReentrantLockPass {
    fn run_pass(
        &self,
        module: &mut Module,
        _manager: &ModuleAnalysisManager
    ) -> PreservedAnalyses {

        for function in module.get_functions() {

            for basic_block in function.get_basic_blocks() {
                for instr in InstructionIterator::new(&basic_block) {
                    self.handle_alias_instructions(instr);
                }
            }
        }
    
        
        for function in module.get_functions() {

            for basic_block in function.get_basic_blocks() {
                for instr in InstructionIterator::new(&basic_block) {
                    self.handle_instruction(instr);
                }
            }
        }

        {
            let program = self.program.borrow();
            let posts = program.compute();
            /*println!("DONE");
            for edge in posts.edge {
               println!("_____\n from: {:?}\n\nto: {:?}\n\nvar: {:?}", edge.0, edge.1, edge.2);
            }

            println!("MAY ALIAS TABLE: {:?}", self.may_alias_table.borrow());

            for release in program.priors().releases {
                println!("_____\n release: {:?}\n\nvar: {:?}", release.0, release.1);
            }*/

            /*for in_ in posts.in_ {
                if in_.0.0.contains("%guard") {
                    println!("_____\n in GUARD: {:?}\n\nvar: {:?}", in_.0, in_.1);
                } else if in_.0.0.contains("%deadlock")  {
                    println!("_____\n in DEADLOCK: {:?}\n\nvar: {:?}", in_.0, in_.1);
                }
            }*/

            if posts.deadlock.len() > 0 {
                println!("MAY DEADLOCK!");
                let mut i = 0;
                for deadlock in posts.deadlock {
                    println!(
                        "__________\nDEADLOCK #{}\n\tFIRST LOCK: {:?}\n\n\tRESOURCE: {:?}\n\n\tSECOND_LOCK: {:?}\n__________", 
                        i, deadlock.0, deadlock.1, deadlock.2
                    );
                    i += 1;
                }
            } else {
                println!("DID NOT FIND A DEADLOCK");
            }

            println!("END ANALYSIS");

        }



        PreservedAnalyses::None

    }
}