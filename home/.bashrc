#!/usr/bin/env bash
################################################################################
# Configure interactive bash shells
#
# ~/.bashrc is only sourced automatically in interactive non-login shells and so
# should be sourced from ~/.bash_profile to effect interactive login shells
################################################################################
source $HOME/.local/lib/bash_utils.sh
if ! is_interactive_shell; then
    # Some programs (e.g. remote shells started by scp) may invoke .bashrc in a
    # non-interactive shell
    # see https://unix.stackexchange.com/questions/257571/why-does-bashrc-check-whether-the-current-shell-is-interactive
    return 0
fi

############################################################################
# Enviornment conifguration
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
# Handle dotfiles that partially support or do not support the XDG base
# directory specification
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export HISTFILE="$XDG_STATE_HOME"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GHCUP_USE_XDG_DIRS=true
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export JULIAUP_DEPOT_PATH="$XDG_DATA_HOME/julia"
# Required for anything before Vim 9.1.0327
export VIMINIT="
    if has ('nvim')
        so ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim
    else
        set nocp
        so ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc
    endif
"

# Set configuration file for non-interactive shells
if [ -f .bash_env ]; then
    export BASH_ENV=".bash_env"
fi

# Make sure shell is set and exported
if [ -z ${SHELL+x} ]; then
    SHELL=/bin/bash
fi
export SHELL

# Update PATH
export PATH=$HOME/.local/bin:$PATH

# Enable 256-color terminal
if [ -n "$TMUX" ]; then
    export TERM='screen-256color'
else
    # Tell programs the current terminal supports xterm's 256 color palette
    # Works even if current terminal is not xterm
    export TERM='xterm-256color'
fi
# Make color output default for bash commands
# - 'ls'
# FreeBSD and MacOSX uses CLICOLOR and LSCOLOR. Linux uses LS_COLOR
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad # Dark color scheme
if command -v dircolors &> /dev/null; then
    eval $(dircolors $XDG_DATA_HOME/dircolors/dircolors.ansi-universal)
fi
#export LS_COLORS=

# Load and configure git prompt utils
# See https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source $HOME/.local/bin/git-prompt.sh
# Unstaged (*) and staged (+) changes will be shown next to the branch name
GIT_PS1_SHOWDIRTYSTATE=true
# Show '$' if there are stash entries
GIT_PS1_SHOWSTASHSTATE=true
# Show '%' if there are untracked files
GIT_PS1_SHOWUNTRACKEDFILES=true
# Show difference between HEAD and its upstream
GIT_PS1_SHOWUPSTREAM="verbose,name"
# Set separator between branch name and state symbols (default: space)
GIT_PS1_STATESEPARATOR="|"
# Add "|CONFLICT" to prompt if there are unresolved conflicts
GIT_PS1_SHOWCONFLICTSTATE=true
# Colored hints
GIT_PS1_SHOWCOLORHINTS=true

# Change Prompt
# See PROMPTING in `man bash`
function prompt_command() {
    # Set variables each time a prompt (PS1) is about to be generated

    # Set separator color based on success of previous command
    if [ $? -eq 0 ]; then
        fmt_color="$fmt_green"
    else
        fmt_color="$fmt_red"
    fi
    PS1_SEPARATOR="${fmt_color}________________________________________________________________________________${fmt_reset}"

    PS1_GIT="$(__git_ps1 \(${fmt_purple}%s${fmt_reset}\))"
    # PS1_GIT="$(__git_ps1 \(%s\))"
}
# Set the number of trailing directory components to retain when expanding the
# \w and \W prompt string escapes
PROMPT_DIRTRIM=5
export PROMPT_COMMAND=prompt_command
# \t = Time in 24-hour HH:MM:SS format
# \w = Working directory
# \h = hostname up to first '.'
export PS1="\
\${PS1_SEPARATOR}\n\
| [${fmt_cyan}\t${fmt_reset}] ${fmt_grey}${fmt_bold}\w ${fmt_reset}\${PS1_GIT} @ ${fmt_yellow}\h${fmt_reset})\n\
| => "

# Set Default Editor (change 'Nano' to the editor of your choice)
export VISUAL=vim
export EDITOR="$VISUAL"

# Set default blocksize when displaying disk memory space in ls, df, du
# https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export BLOCKSIZE=1k # 1024 byte blocks

################################################################################
# Useful functions and aliases
alias showPATH="tr ':' '\n' <<< \""'$PATH'"\""
alias showPYPATH="tr ':' '\n' <<< \""'$PYTHONPATH'"\""
# Verbose ls
alias ll='ls -FGlAhpa'
 # Tally up occurances in output
alias tally='sort | uniq -c | sort -rn'
# Disk usage of folders/files in pwd
alias dupwd="du -a -h -d 1 | sort -hr"
# Activate virtual environments
alias activate="source $HOME/.local/bin/activate.sh"

# NOTE: Be cautious when overriding cd, grep, find, or ls. It can break other tools.
# Safer options
alias rm='rm -I'
alias mv='mv -i'
# Preferred options
# NOTE: Don't make '--recursive' default. It messes up piping from stdout
alias grep='grep --color=auto --binary-files=without-match'

command_exists rg  && alias rg='rg --smart-case';
command_exists bat && alias cat='bat';
if command_exists eza; then
    # NOTE: Don't override ls. It breaks tab-completion (at least in zshell
    # on my Mac)
    alias la='eza --all --group-directories-first'
    alias ll='eza --all --group-directories-first --long --header --icons --smart-group --git'
fi

################################################################################
# Site specific configuration
machine_bashrc=$HOME/.bashrc-local
if [ -f $machine_bashrc ]; then
    # Add symlink to include machine profile using above name convention
    source $machine_bashrc
fi

################################################################################
export PATH=$(remove_path_duplicates "$PATH")
export PYTHONPATH=$(remove_path_duplicates "$PYTHONPATH")

################################################################################
# Print about completion if in interactive shell
print_shell_type
print_success "== Completed running .bashrc =="
