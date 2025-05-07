dotfiles
========

My configuration files

The basic layout is
|            | Target Directory   | Description                                    |
| --------:  | :----------------: | :----------                                    |
| `config/`  | `$XDG_CONFIG_HOME` | Configuration dotfiles                         |
| `home/`    | `$HOME`            | Non-XDG supported configuration dotfiles       |
| `local/`   | `$HOME/.local`     | Files for `bin/`, `lib/`, and `share/`         |
| `windows/` |                    | Microsoft windows specific configuration files |
| `machine/` |                    | Machine specific configuration files           |
| `scripts/` |                    | Miscalleneous scripts                          |


# Setup

Clone the repo and then from inside it run
```sh 
source install.sh
```
## Local configuration
* symlink machine specific configs from `machine/`:
    * bashrc -> ~/.bashrc-machine
* edit `config/git/config-local-template` and then copy it to `config/git/config-local`
