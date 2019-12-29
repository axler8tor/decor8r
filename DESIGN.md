# Design #
_decor8r_. How it hangs together, what drove the decisions, how it works. This is a work in progress, design decisions are made based on the project road map. Nothing is set in stone during the first couple of releases. Things can change drastically if compelling reasons arise.


## Architecture ##
_**decor8r**_ follows a general client-server architecture. The servers is called the _**decor8r**_ _daemon_ (_daemon_) and the client is called the _**decor8r**_ _client_ (_client_). On startup the _daemon_ reads one or more configuration files to establish the decoration rules, themes and options. The _daemon_ can be instructed to refresh its configuration on demand. The _daemon_ gets requests from _client_, builds the decoration according to the configuration rules and pass the decoration back to the client which displays the decorated prompt or status line.

The following graphic shows an example of _**decor8r**_'s most likely high-level architecture as of version 0.1.x:
![Alt Diagram](__design/decor8r-arch-20191229121452.svg)

The _daemon_ front end accepts requests from clients, forwards the requests to the appropriate _daemon_ back end components which produces the decorations according to configuration rules.


## 0.1.1 ##
_2019-12-28_

### Technology Decisions ###
The following table shows the technology decisions for version 0.1.1:
| Component             | Technology
|                   ---:|----
| **Client**            | No implementation technology decided on in version 0.1.x
| **Back End**          | Elixir
| **C/S Communication** | No technology is decided on for how a _client_ will communicate with the _daemon_.

### Considerations ###
The following table shows which technologies was considered for clients, back ends and communication protocols:
| Component     | Technology
|           ---:|---
| **Client**    | Rust, Nim, Python, Reason/OCaml
| **Back End**  | Rust, Reason/Ocaml
| **Comms**     | Socket, RPC, Rest, MessagePack

### Rationale ###
The reasons Elixir was chosen as the back-end technology are:
1. It is mature
1. I am familiar with it
1. It has a vibrant, helpful community
1. It has stable implementations for macOS, BSD, Solaris and Linux

### Resolution Timelines ###
The following table shows when design decisions (**R**) will be resolved:
| Component     | Resolution (**R**)
|           ---:|---
| **Client**    | 0.1.1 < **R** < 0.2.0
| **Back End**  | 0.1.1
| **Comms**     | 0.1.1 < **R** < 0.2.0


## R&D ##
+ [Markdown Cheat sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
+ [UTFx Characters](https://www.fileformat.info/info/charset/UTF-8/list.htm)
+ [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
+ [Erlang Sockets](https://learnyousomeerlang.com/buckets-of-sockets)
+ [Git Book](https://git-scm.com/book/en/v2)
+ [Graphs](https://mermaid-js.github.io/mermaid/#/)
+ [Graphs Live Editor](https://mermaid-js.github.io/mermaid-live-editor)
+ [Merge Maps & Structs](https://stackoverflow.com/questions/30997475/load-values-into-a-struct-from-a-map-in-elixir)
+ [Initialize Struct](https://stackoverflow.com/questions/30927635/in-elixir-how-do-you-initialize-a-struct-with-a-map-variable)
+ [MessagePack](https://msgpack.org/)
+ [ZSH Test](https://unix.stackexchange.com/questions/131716/start-zsh-with-a-custom-zshrc)
+ [Credo](https://github.com/rrrene/credo)
+ [Dialyxir](https://github.com/jeremyjh/dialyxir)
+ [Umbrella Projects](https://duckduckgo.com/?q=when+to+use+umbrella+project+elixir&t=braveed&ia=web)