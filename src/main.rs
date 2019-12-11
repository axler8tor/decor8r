fn main() {
    if let Ok(cwd) = decor8r::cwd() {
        println!("CWD: {}", cwd.as_path().display());
        if let Ok(compressed) = decor8r::compress(&cwd) {
            println!("CCWD: {}", compressed.as_path().display())
        }
    }

    match decor8r::cwd() {
        Err(e) => println!("Error: {}", e),
        Ok(p) => println!("Path: {}", p.display()),
    }

    //let ccwd = decor8r::compress(cwd);
}
