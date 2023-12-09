use llvm_plugin::inkwell::basic_block::{BasicBlock, self};
use regex::Regex;
use llvm_plugin::inkwell::values::{InstructionValue, InstructionOpcode, AsValueRef, BasicValueEnum};
use llvm_plugin::utils::InstructionIterator;
use rustc_demangle::demangle;

pub struct InstructionCallSites;


impl InstructionCallSites {

    pub fn called_function_name_from_str(instr_str : &str) -> Result<String, anyhow::Error> {

        let re = Regex::new(r"(call|invoke) [^@]+@([^(\s]+)").unwrap();

        if let Some(caps) = re.captures(instr_str) {
            if let Some(function_name) = caps.get(2) {
                // Trim double quotes if present
                let trimmed_name = function_name.as_str().trim_matches(|c: char| !c.is_alphanumeric());
                return Ok(trimmed_name.to_string());
            }
        } 
    
        Err(anyhow::anyhow!("Could not parse function name from instruction: {}", instr_str))
    
    }

    pub fn called_function_name(instr : &InstructionValue) -> Result<String, anyhow::Error> {

        match instr.get_opcode() {
            InstructionOpcode::Call | InstructionOpcode::Invoke => { // we don't care about error handling, so these can be the same thing
                let instr_str = instr.to_string();
                Self::called_function_name_from_str(&instr_str)
            },
            _ => {
                Err(anyhow::anyhow!("Instruction is not a call instruction"))
            }
        }

    }

    pub fn demangled_called_function_name(instr : &InstructionValue) -> Result<String, anyhow::Error> {

        let function_name = Self::called_function_name(instr)?;

        Ok(demangle(&function_name).to_string())

    }

 

}

pub enum KnownCallsites {
    StdSyncMutexLock,
    StdSyncMutexNew,
    StdSyncMutexDrop,
    Unknown
}

impl KnownCallsites {

    pub fn is_std_sync_mutex_lock_call(call_str : &str) -> bool {

        call_str.starts_with("std::sync::mutex::Mutex<T>::lock")
     
    }

    pub fn is_std_sync_mutex_lock_call_site(instr : &InstructionValue) -> Result<bool, anyhow::Error> {

        let call_str = InstructionCallSites::demangled_called_function_name(instr)?;
        Ok(Self::is_std_sync_mutex_lock_call(&call_str))
    
    }

    pub fn is_std_sync_mutex_new_call(call_str : &str) -> bool {

        call_str.starts_with("std::sync::mutex::Mutex<T>::new")
     
    }

    pub fn is_std_sync_mutex_new_call_site(instr : &InstructionValue) -> Result<bool, anyhow::Error> {

        let call_str = InstructionCallSites::demangled_called_function_name(instr)?;
        Ok(Self::is_std_sync_mutex_new_call(&call_str))
    
    }

    pub fn is_std_sync_mutex_drop(call_str : &str) -> bool {

        call_str.starts_with("core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>::")
     
    }

    pub fn is_std_sync_mutex_drop_call_site(instr : &InstructionValue) -> Result<bool, anyhow::Error> {

        let call_str = InstructionCallSites::demangled_called_function_name(instr)?;
        Ok(Self::is_std_sync_mutex_drop(&call_str))
    
    }

    pub fn try_from_instr(instr : &InstructionValue) -> Result<Self, anyhow::Error> {

        let call_str = InstructionCallSites::demangled_called_function_name(instr)?;

        if Self::is_std_sync_mutex_lock_call(&call_str) {
            return Ok(Self::StdSyncMutexLock);
        } else if Self::is_std_sync_mutex_new_call(&call_str) {
            return Ok(Self::StdSyncMutexNew);
        } else if Self::is_std_sync_mutex_drop(&call_str) {
            return Ok(Self::StdSyncMutexDrop);
        }

        Ok(Self::Unknown)

    }

    pub fn from_instr(instr : &InstructionValue) -> Self {

        Self::try_from_instr(instr).unwrap_or(Self::Unknown)

    }

}

pub struct Predecessors;

impl Predecessors {
    // ! This is broken. Inkwell does not seem to have an appropriate API to accomplish this.
    pub fn get_predecessors(instruction: InstructionValue) -> Vec<InstructionValue> {

        let mut ret = Vec::new();
        if let Some(prev_inst) = instruction.get_previous_instruction(){ // ! this only gets the previous instruction in the basic block
            ret.push(prev_inst);
        }
    
        if let Some(block) = instruction.get_parent() {
            
            if let Some(first_instruction) = block.get_first_instruction() {
                if first_instruction != instruction {
                    return ret;
                }
            }
            // println!("__________");
            // println!("block: {:?}", block.get_name());

            if let Some(parent) = block.get_parent() {
                for iter in parent.get_basic_blocks() {

                    for instruction in InstructionIterator::new(&iter) {

                        let name_with_quotes = format!("{:?}", block.get_name()); // This will have quotes due to Debug formatting
                        let trimmed_name = name_with_quotes.trim_matches('"'); // This removes leading and trailing quotes

                        let pattern = format!("label %{}", trimmed_name);

                        if instruction.to_string().contains(
                            pattern.as_str()
                        ) {
                            ret.push(instruction);
                            // println!("pred: {:?}", iter);
                        }

                    }

                    /*loop {
                        // println!("iter: {:?}", iter.get_name());
                        if let Some(last_inst) = iter.get_last_instruction() {
                            ret.push(last_inst);
                        }

                        if let Some(next_block) = iter.get_next_basic_block() {
                            iter = next_block;
                        } else {
                            break;
                        }
                    }*/

                }
                
                // ! Also tried this, but it messes up reaching definitions.
                /*for inner_block in parent.get_basic_blocks() {

                    println!("inner_block: {:?}", inner_block.get_name());
                    if let Some(last_inst) = inner_block.get_last_instruction() {
                        if inner_block != block {
                            ret.push(last_inst);
                        }
                    }
                }*/

            }

        }
    
        ret

    }

    pub fn get_jump_labels(basic_block: &BasicBlock) -> Vec<String> {

        let mut ret = Vec::new();
    
        let instruction_str = format!("{:?}", basic_block);

        let re = Regex::new(r"label %([a-zA-Z0-9_]+)");

        match re {
            Ok(re) => {
                for cap in re.captures_iter(&instruction_str) {
                    ret.push(cap[1].to_string());
                }
                ret
            },
            Err(_) => {
                // println!("Error: Could not parse jump labels from instruction: {}", instruction_str);
                ret
            }

        }

    }

}

pub struct Alloca;

impl Alloca {

    pub fn get_type_from_alloca_str(instr_str : &str) -> Result<String, anyhow::Error> {

        let re = Regex::new(r"(alloca (.*?),)").unwrap();;

        // return Ok("".to_string());

        if let Some(caps) = re.captures(instr_str) {
            if let Some(function_name) = caps.get(2) {
                // Trim double quotes if present
                let trimmed_name = function_name.as_str().trim_matches(|c: char| !c.is_alphanumeric());
                return Ok(trimmed_name.to_string());
            }
        } 
    
        Err(anyhow::anyhow!("Could  not parse type from fun tion: {}", instr_str))
    
    }

}

pub enum KnowAlloca {
    MutexGuard,
    Unknown
}

impl KnowAlloca {

    pub fn is_mutex_guard(instr : &InstructionValue) -> bool {

    
    
        let type_str = Alloca::get_type_from_alloca_str(format!("{:?}", instr).as_str()).unwrap();
        type_str.to_string().contains("core::result::Result<std::sync::mutex::MutexGuard")
    


    }

    pub fn try_from_instr(instr : &InstructionValue) -> Result<Self, anyhow::Error> {

        if Self::is_mutex_guard(instr) {
            return Ok(Self::MutexGuard);
        }

        Err(anyhow::anyhow!("Unknown alloca type"))

    }

    pub fn from_instr(instr : &InstructionValue) -> Self {

        Self::try_from_instr(instr).unwrap_or(Self::Unknown)

    }

}

pub struct Var;

impl Var {

    pub fn get_var_name_from_instr(instr : &InstructionValue) -> String {

        let name_with_quotes = format!("{:?}", 
            instr.get_name().expect("Could not get name from instruction") // This will have quotes due to Debug formatting
        ); // This will have quotes due to Debug formatting
        let trimmed_name = name_with_quotes.trim_matches('"'); // This removes leading and trailing quotes

        let full_name = format!("%{} {:?}", trimmed_name, instr.as_value_ref());

        full_name
    
    }

    pub fn get_var_name_from_basic_value(instr : &BasicValueEnum) -> String {

        // should be a pointer type
        let address = instr.as_value_ref();

        let name_with_quotes = format!(
            "{:?}", 
            instr.into_pointer_value().get_name()
        ); // This will have quotes due to Debug formatting
        let trimmed_name = name_with_quotes.trim_matches('"'); // This removes leading and trailing quotes

        let full_name = format!("%{} {:?}", trimmed_name, address);

        full_name
    
    }

}