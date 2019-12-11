extern crate dirs;

use std::env;
use std::error;
use std::fmt;
use std::io;
use std::path;

#[derive(Debug)]
enum PathError {
    Cwd(io::Error),
    Compress
 }

impl fmt::Display for PathError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            PathError::Cwd(ref err) => write!(f, "IO error: {}", err),
            PathError::Compress => write!(f, "Compress error: {}", 0)
        }
    }
}

impl error::Error for PathError {
    fn cause(&self) -> Option<&dyn error::Error> {
        match *self {
            PathError::Cwd(ref err) => Some(err),
            PathError::Compress => Some(&PathError::Compress)
        }
    }
}


pub fn cwd() -> io::Result<path::PathBuf> {
    let cwd = env::current_dir()?;
    Ok(cwd)
}

pub fn compress(path: &path::PathBuf) -> io::Result<path::PathBuf> {
    if let Some(home) = dirs::home_dir() {
        if let Ok(compressed) = path.strip_prefix(home.to_path_buf()) {
            let mut tilde = path::PathBuf::from("~");
            tilde.push(compressed);
            Ok(tilde)
        } else {
            Err(io::Error::from(io::ErrorKind::InvalidInput))
        }
    } else {
        Err(io::Error::from(io::ErrorKind::NotFound))
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn some_test() { }
}
