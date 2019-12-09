fn main() {
    let cwd = decor8r::cwd();

    match cwd {
        Err(e) => println!("Error: {}", e),
        Ok(p) => println!("Path: {}", p.display()),
    }
}
