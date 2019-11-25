extern crate clap;

use std::error::Error;

pub enum Colors {
    None,
    Black,
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Cyan,
    Voilet,
    Magenta,
    White,
}

pub enum Side {
    Left,
    Right,
}

pub struct Decoration {}

impl Decoration {}

pub fn dispatch(state: clap::ArgMatches) -> Result<(), Box<dyn Error>> {
    match state.subcommand_name() {
        Some("zsh") => println!("zsh"),
        Some("tmux") => println!("tmux"),
        Some("vim") => println!("vim"),
        _ => println!("Something else...")
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    #[test]
    fn new_decoration() { }
}
