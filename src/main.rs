#[macro_use]
extern crate clap;

use std::process;

/*
fn app<'a, 'b>() -> clap::App<'a, 'b> {
    clap::App::new("koos")
}
*/

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
                    .long("mode")
                    .short("m")
                    .value_name("MODE")
                    .possible_values(&["auto", "8", "16", "256"])
                    .default_value("16")
                    .global(true)
            )
            .arg(
                clap::Arg::with_name("config")
                    .help("Configuration file.")
                    .long("config")
                    .short("c")
                    .value_name("PATH")
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

    if let Err(e) = decor8r::dispatch(clargs) {
        println!("Error: {}", e);

        process::exit(1);
    }
}
