#!/bin/bash
cargo b -p llvm-lock-detection
rustc ./test/single_mock_deadlock_std_sync.rs --emit=llvm-ir
opt-16 --load-pass-plugin=target/debug/libllvm_lock_detection.so --passes=reentrant-lock-detection ./test/single_mock_deadlock_std_sync.ll