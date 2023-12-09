use std::sync::Mutex;

fn main() {

    let mut x = 64;
    let mut safe_x = Mutex::new(x);
    
    {
        let mut guard = safe_x.lock().unwrap();
        *guard += 1;
        println!("Here is fine x: {}", *guard);
    }

    {
        let mut no_deadlock = safe_x.lock().unwrap();
        *no_deadlock += 1;
        println!("Should also get here x: {}", *no_deadlock);
    }

}