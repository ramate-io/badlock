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