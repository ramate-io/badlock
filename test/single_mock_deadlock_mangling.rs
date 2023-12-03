#[inline(never)]
fn acquire_lock(x : &u64) {
    // ! no-op
}

#[inline(never)]
fn release_lock(x : &u64) {
    // ! no-op
}

fn locks(x : &u64) {

    acquire_lock(x);
    let a = 0;
    let b = a + 3;
    release_lock(x);

}

fn deadlocks(x : &u64) {

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

    let x = 64;
    deadlocks(&x);

}