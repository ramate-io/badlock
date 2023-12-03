# badlock
Static deadlock detection for Rust programs using LLVM compiler infrastructure and taint analysis. 

## Work In Progress (WIP)

🚧 **This project is currently a work in progress.** 🚧

### What does this mean?

- The code, features, and documentation are not final and are subject to change.
- Some functionalities might be incomplete or experimental.
- There may be bugs, and performance might not be optimized.

### What to expect?

- Regular updates and improvements.
- More features will be added as the project evolves.
- Better documentation and guides in future releases.

### Short-term Intended Outcomes

#### Reentrant Deadlocks
In the short term, the intent is to be able to detect reentrant deadlocks. That is, deadlocks of the following form:

```rs
extern "C" {
    fn _acquire_ptr_lock(ptr: *const i32);
    fn _release_ptr_lock(ptr: *const i32);
}

fn acquire_ptr_lock<X>(_x : &X) {
    unsafe {
        _acquire_ptr_lock(&_x as *const _ as *const i32);
    }
}

fn release_ptr_lock<X>(_x : &X) {
    unsafe {
        _release_ptr_lock(&_x as *const _ as *const i32);
    }
}

fn locks<X>(x : &X) {

    acquire_ptr_lock(x);
    let a = 0;
    let b = a + 3;
    release_ptr_lock(x);

}

fn deadlocks<X>(x : &X) {

    acquire_ptr_lock(x);
    let a = 1;
    let b = 3 * a;
    locks(x);
    release_ptr_lock(x);

}

struct X {
    a : i32,
    b : i32,
}

fn main() {

    let x = X { a : 0, b : 0 };
    deadlocks(&x);

}
```

#### Support for `std::sync` Deadlocks
Once basic deadlock detection against mocks like the above is facilitated, `badlock` intends to first support lock types in `std::sync`.

#### CLI
Shortly after the implementation against `std::sync` is finished, a `badlock` CLI should be released to wrap up the static pass into an easily consumable program. 
