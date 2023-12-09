# badlock
Static reentrant deadlock detection for Rust programs using LLVM compiler infrastructure and taint analysis. 

We recommend you reopen this repo in VsCode with the [Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension. This will automatically build the docker container and install all the necessary dependencies. Use the `rust-llvm` container configuration.

## Work In Progress (WIP)

🚧 **This project is currently a work in progress.** 🚧

## Overview
This project contains the following components:
- A generalized deadlock analysis crate, `badlock/lock-detection` using rust [`crepe`](https://github.com/ekzhang/crepe) (a tool for embedding datalog based programs in Rust).
- A Rust [`inkwell`](https://github.com/TheDan64/inkwell) and [`llvm-plugin`](https://github.com/jamesmth/llvm-plugin-rs) based LLVM pass, `badlock/llvm-lock-detection`, that can detect `std::sync::Mutex` reentrant deadlocks in Rust programs.
- A few e2e examples in `tests`.

### `badlock/lock-detection`
The `badlock/lock-detection` crate contains a generalized deadlock analysis that can be used to detect deadlocks in any program that can be modeled as a graph. The best entrypoint for understanding the crate is [here](./badlock/lock-detection//src//reentrant_lock_detection//facts.rs).

You can run several tests against mini-programs using `cargo test` in the `badlock/lock-detection` directory or by using the Rust Analyzer test running tools in VsCode. We highly recommend you check these tests in detail to understand how deadlocks are being detected.

We have additionally an abstraction layer over the `crepe` crate that allows for the use of generic types with `crepe` programs. This is used in the `badlock/llvm-lock-detection` crate to allow for the use of `inkwell` types with `crepe` programs.

### `badlock/llvm-lock-detection`
This crate contains an LLVM pass that can detect reentrant deadlocks in Rust programs. The pass is written using the `inkwell` and `llvm-plugin` crates. The pass is written in Rust and can be compiled to a shared library. You can later use this shared lib with `opt` to statically analyze LLVM IR compiled from a Rust program.

**WARNING**: owing to limitations in `inkwell` which are discussed below, the current implementation is quite hacky. This pass should be considered a proof of concept.

### `test`
To run the deadlock detection on all targets.
```
make
```

Inspect the analysis output in the `%.analysis` artifacts. You should see something like this...
```
```
