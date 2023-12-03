fn acquire_lock<X>(_x : &X) {
    // ! no-op
}

fn release_lock<X>(_x : &X) {
    // ! no-op
}

fn locks<X>(x : &X) {

    acquire_lock(x);
    let a = 0;
    let b = a + 3;
    release_lock(x);

}

fn dealocks<X>(x : &X) {

    acquire_lock(x);
    let a = 1;
    let b = 3 * a;
    locks(x);
    release_lock(x);

}

struct X {
    a : i32,
    b : i32,
}

fn main() {

    let x = X { a : 0, b : 0 };
    dealocks(&x);

}