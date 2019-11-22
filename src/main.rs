#[macro_use]
extern crate clap;


fn main() {
    let clargs = clap::App::new("decor8r")
            .author("Axl Mattheus, decor8r@axl.tech")
            .version(crate_version!())
            .about("Decorate terminal-based status lines or prompts.")
            .long_about(
                "Produce decorated zsh, tmux and neovim status lines or command prompts. Inspried by powerline."
            )
            .arg(
                clap::Arg::with_name("color")
                    .help("Color display mode.")
                    .takes_value(true)
                    .long("color")
                    .short("c")
                    .alias("colour")
                    .value_name("MODE")
                    .possible_values(&["auto", "8", "16", "256"])
                    .default_value("16")
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
            ).get_matches();

    match clargs.subcommand_name() {
        Some("zsh") => println!("zsh"),
        Some("tmux") => println!("tmux"),
        Some("nnvm") => println!("nvim"),
        _ => println!("Something else..."),
    }
}

#[cfg(test)]
mod tests {}
