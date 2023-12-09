#!/bin/bash
cargo b -p llvm-lock-detection
rustc ./test/$1.rs --emit=llvm-ir
opt-16 --load-pass-plugin=target/debug/libllvm_lock_detection.so --passes=reentrant-lock-detection $1.ll