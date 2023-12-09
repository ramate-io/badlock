# badlock
Static reentrant deadlock detection for Rust programs using LLVM compiler infrastructure and taint analysis. 

## Work In Progress (WIP)

🚧 **This project is currently a work in progress.** 🚧

### Overview
This project contains the following components:
- A generalized deadlock analysis crate, `badlock/lock-detection` using rust [`crepe`](https://github.com/ekzhang/crepe) (a tool for embedding datalog based programs in Rust).
- A Rust [`inkwell`](https://github.com/TheDan64/inkwell) and [`llvm-plugin`](https://github.com/jamesmth/llvm-plugin-rs) based LLVM pass, `badlock/llvm-lock-detection`, that can detect `std::sync::Mutex` reentrant deadlocks in Rust programs.
- A few examples in `tests`.

### `badlock/lock-detection`