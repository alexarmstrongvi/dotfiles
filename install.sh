REPO_PATH="$(realpath ${BASH_SOURCE[0]})"
if [ ! -d "$REPO_PATH" ]; then
    echo "ERROR | Unable to determine dotfiles repo path"
    exit 1
fi
source $REPO_PATH/local/lib/bash_utils.sh

################################################################################
# Globals
################################################################################
# Default to $HOME/.config if XDG_CONFIG_HOME isn't set
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

################################################################################
# Functions
################################################################################
checked_ln() { 
    local src="$1"
    local tgt="$2"
    if [[ -L "$tgt" && "$(readlink $tgt)" = "$src" ]]; then
        # echo "DEBUG | Symlink already exists for $src"
        return 0
    fi
    if [ -L "$tgt" ]; then
        echo "WARNING | Symlink exists: $tgt -> $(readlink $tgt)"
    fi
    if [ -d "$tgt" ]; then
        if [ -L "$tgt" ]; then
            rm -i "$tgt"
        else
            echo "ERROR | Target directory exists and is not a symlink: $tgt"
            return 1
        fi
    fi
    ln -isvw "$1" "$2" 
}

################################################################################
# Main
################################################################################
# echo "DEBUG | CONFIG_HOME = $CONFIG_HOME"
# echo "DEBUG | REPO_PATH = $REPO_PATH"

# Link XDG config files
if [[ ! -d "$CONFIG_HOME" || -L "$CONFIG_HOME" ]]; then
    checked_ln ${REPO_PATH}/config "$CONFIG_HOME"
else
    for p in "${REPO_PATH}/config"/*; do
        echo "A: $p"
        checked_ln "$p" "${CONFIG_HOME}/$(basename $p)"
    done
fi

# Link non-XDG compliant config files
for p in "${REPO_PATH}/home"/.*; do
    checked_ln "$p" "${HOME}/$(basename $p)"
done

# Link .local files
for p in $(find "${REPO_PATH}/local" -type f); do
    dn="$(dirname $p)"
    tgt_dir="$HOME/.local${dn#$REPO_PATH/local}"
    [ -d "$tgt_dir" ] || mkdir -pv "$tgt_dir"
    bn="$(basename $p)"
    [ "$bn" = ".gitkeep" ] && continue
    checked_ln "$p" "$tgt_dir/$(basename $p)"
done

# Special handling
for p in "$REPO_PATH/config/vscode"/{keybindings.json,settings.json,snippets}; do
    tgt_dir="$HOME/Library/Application Support/Code/User"
    if [ ! -d "$tgt_dir" ]; then
        echo "WARNING | Unable to find VSCode settings file location"
        break
    fi
    checked_ln "$p" "$tgt_dir/$(basename $p)" 
done

print_success "dotfile installation complete"
