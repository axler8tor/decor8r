extern crate clap;

fn main() {
    let clargs = clap::App::new("decor8r")
        .version("0.1.0")
        .about("Decorate terminal-based applications.")
        .arg(
            clap::Arg::with_name("foregroung")
                .help("Foreground colour.")
                .long("foreground")
                .short("f")
                .default_value("FOREGROUND_WHITE") // change to enumb
                .global(true)
        )
        .arg(
            clap::Arg::with_name("backgroung")
                .help("Background colour.")
                .long("background")
                .short("b")
                .default_value("BACKGROUND_BLACK") // change to enum
                .global(true)
        )
        .subcommand(
            clap::SubCommand::with_name("zsh")
                .about("Decorate zsh command lines.")
        )
        .subcommand(
            clap::SubCommand::with_name("tmux")
                .about("Decorate tmux sesions.")
        )
        .subcommand(
            clap::SubCommand::with_name("nvim")
                .about("Decorate neovim status lines.")
        )
        .get_matches();

    match clargs.subcommand_name() {
        Some("zsh") => println!("zsh"),
        Some("tmux") => println!("tmux"),
        Some("nnvm") => println!("nvim"),
        _ => println!("Something else...")
    }
}

#[cfg(test)]
mod tests {}
