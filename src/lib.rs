extern crate clap;

use std::error::Error;

#[derive(PartialEq)]
#[derive(Debug)]
pub enum Color {
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

#[derive(PartialEq)]
#[derive(Debug)]
pub struct Decoration {
    pub begin: String,
    pub end: String,
    pub foreground: Color,
    pub background: Color,
    pub content: String,
}

impl Decoration {
    fn new<S>(begin: S, end: S, foreground: Color, background: Color, content: S) -> Decoration
    where
        S: Into<String>,
    {
        Decoration {
            begin: begin.into(),
            end: end.into(),
            foreground,
            background,
            content: content.into(),
        }
    }
}

pub fn dispatch(state: clap::ArgMatches) -> Result<(), Box<dyn Error>> {
    match state.subcommand_name() {
        Some("zsh") => println!("zsh"),
        Some("tmux") => println!("tmux"),
        Some("vim") => println!("vim"),
        _ => println!("Something else..."),
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    #[test]
    fn new_decoration() {
        let lhs = crate::Decoration {
            begin: String::from("B"),
            end: String::from("E"),
            foreground: crate::Color::None,
            background: crate::Color::None,
            content: String::from("C"),
        };

        let rhs = crate::Decoration::new("B", "E", crate::Color::None, crate::Color::None, "C");

        assert_eq!(lhs, rhs)
    }
}
