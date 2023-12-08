use regex::Regex;
use llvm_plugin::inkwell::values::{InstructionValue, InstructionOpcode, FunctionValue, AsValueRef};
use llvm_plugin::inkwell::values::BasicValueEnum;
use llvm_plugin::utils::InstructionIterator;
use either::Either;
use llvm_plugin::inkwell::values::AnyValue;
use rustc_demangle::demangle;

#[test]
fn main() {
    let llvm_instruction = r#"%_4 = call zeroext i1 @"_ZN3std4sync6poison20PoisonError$LT$T$GT$3new17h69146b16e83f7294E"(i1 zeroext %8)"#;
    let function_name = InstructionCallSites::called_function_name_from_str(llvm_instruction).unwrap();
    println!("function_name: {}", function_name);
}

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