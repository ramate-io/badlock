use std::sync::Mutex;

fn main() {

    let mut safe_x = Mutex::new(64);
    
    let mut guard = safe_x.lock().unwrap();
    *guard += 1;
    println!("Here is fine x: {}", *guard);

    let mut deadlock = safe_x.lock().unwrap();
    *deadlock += 1;
    println!("Should never get here x: {}", *guard);

}