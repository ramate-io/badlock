use llvm_plugin::inkwell::basic_block;
use llvm_plugin::inkwell::module::Module;
use llvm_plugin::{
    LlvmModulePass, ModuleAnalysisManager, PassBuilder, PipelineParsing, PreservedAnalyses,
};
use lock_detection::reentrant_lock_detection;
use std::cell::RefCell;

// A name and version is required.
#[llvm_plugin::plugin(name = "reentrant_lock_detection", version = "0.1")]
fn plugin_registrar(builder: &mut PassBuilder) {
    // Add a callback to parse a name from the textual representation of
    // the pipeline to be run.
    builder.add_module_pipeline_parsing_callback(|name, manager| {
        if name == "reentrant-lock-detection" {
            // the input pipeline contains the name "custom-pass",
            // so we add our custom pass to the pass manager
            manager.add_pass(ReentrantLockPass);

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

#[derive(Debug, Clone)]
struct ReentrantLockPass {
    // interior mutability on reentrant lock detection Program
    pub program: RefCell<reentrant_lock_detection::Program>,
}

impl LlvmModulePass for ReentrantLockPass {
    fn run_pass(
        &self,
        module: &mut Module,
        manager: &ModuleAnalysisManager
    ) -> PreservedAnalyses {
        // transform the IR
        
        for function in module.get_functions() {
            println!("function: {:?}", function);
            for basic_block in function.get_basic_blocks() {
                println!("instruction: {:?}", instruction);
                for instruction in basic_block.get_instructions() {
                    println!("instruction: {:?}", instruction);
                }
            }
        }

    }
}