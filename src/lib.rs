extern crate directories;

use std::env;
use std::path;

pub fn cwd() -> std::io::Result<path::PathBuf> {
    let cwd = env::current_dir()?;
    Ok(cwd)
}

#[cfg(test)]
mod tests {
    #[test]
    fn some_test() { }
}
