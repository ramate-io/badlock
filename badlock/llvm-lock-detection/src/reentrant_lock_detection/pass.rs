use llvm_plugin::inkwell::basic_block;
use llvm_plugin::inkwell::module::Module;
use llvm_plugin::{
    LlvmModulePass, ModuleAnalysisManager, PassBuilder, PipelineParsing, PreservedAnalyses,
};
use lock_detection::reentrant_lock_detection;
use std::cell::RefCell;
use rustc_demangle::demangle;
use llvm_plugin::inkwell::values::{InstructionValue, InstructionOpcode, FunctionValue, AsValueRef};
use llvm_plugin::inkwell::values::BasicValueEnum;
use llvm_plugin::utils::InstructionIterator;
use either::Either;
use llvm_plugin::inkwell::values::AnyValue;
use crate::util::llvm_ir::{
    KnownCallsites, InstructionCallSites
};

// A name and version is required.
#[llvm_plugin::plugin(name = "reentrant_lock_detection", version = "0.1")]
fn plugin_registrar(builder: &mut PassBuilder) {
    // Add a callback to parse a name from the textual representation of
    // the pipeline to be run.
    builder.add_module_pipeline_parsing_callback(|name, manager| {
        if name == "reentrant-lock-detection" {
            // the input pipeline contains the name "custom-pass",
            // so we add our custom pass to the pass manager
            manager.add_pass(ReentrantLockPass::default());

            // we notify the caller that we were able to parse
            // the given name
            PipelineParsing::Parsed
        } else {
            // in any other cases, we notify the caller that our
            // callback wasn't able to parse the given name
            PipelineParsing::NotParsed
        }
    });
}

#[derive(Debug, Clone, Hash, PartialEq, Eq)]
pub struct Symbol(String);

#[derive(Debug, Clone)]
struct ReentrantLockPass {
    // interior mutability on reentrant lock detection Program
    pub program: RefCell<reentrant_lock_detection::Program<Symbol>>,
}

impl Default for ReentrantLockPass {
    fn default() -> Self {
        Self {
            program: RefCell::new(reentrant_lock_detection::Program::new()),
        }
    }
}

impl ReentrantLockPass {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn handle_instruction(&self, inst : InstructionValue) {
        
        match inst.get_opcode() {
            InstructionOpcode::Call  | InstructionOpcode::Invoke => { // we don't care about error handling, so these can be the same thing
               self.handle_call_inst(inst);
            },
            _ => {
               
            }
        }

    }

    fn handle_call_inst(&self, inst : InstructionValue) {
       // 
       match InstructionCallSites::demangled_called_function_name(&inst) {
           Ok(function_name) => {
               // println!("function_name: {}", function_name);
               match KnownCallsites::from_instr(&inst) {
                   KnownCallsites::StdSyncMutexLock => {
                        let target = &inst.get_operand(0).unwrap();
                        println!("Acquires lock on {:?} as {:?}", target, inst.get_operand(1).unwrap());
                   },
                   KnownCallsites::StdSyncMutexNew => {
                        println!("Creates lock for {:?} as {:?}", &inst.get_operand(0), inst)
                   },
                   KnownCallsites::StdSyncMutexDrop => {
                       println!("Drops lock for {:?}", &inst.get_operand(0).unwrap());
                   },
                   KnownCallsites::Unknown => {
                       // println!("Unknown");
                   }
                   
               }
           },
           Err(e) => {
               println!("Error: {}", e);
           }
           
       }

    }

}

impl LlvmModulePass for ReentrantLockPass {
    fn run_pass(
        &self,
        module: &mut Module,
        manager: &ModuleAnalysisManager
    ) -> PreservedAnalyses {
        // transform the IR
        
        for function in module.get_functions() {
            /*println!("function: {:?}", function);
            let str_name = function.get_name().to_str().unwrap();
            let demangled = demangle(str_name).to_string();
            println!("demangled: {:?}", demangled);*/
            for basic_block in function.get_basic_blocks() {
                for instr in InstructionIterator::new(&basic_block) {
                    self.handle_instruction(instr);
                }
            }
        }

        PreservedAnalyses::None

    }
}