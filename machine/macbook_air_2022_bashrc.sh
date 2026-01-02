################################################################################
# Configure interactive bash shells on my Macbook Air 2022
################################################################################
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
PATH="${PATH}:${HOME}/.local/bin"
PATH="${PATH}:${HOME}/.ghcup/bin" # Haskell GHCup (not managed by homebrew)
export PATH

# Set project folders for activate_tmux_session
export MY_PROJECT_DIRS=" \
${HOME} \
${HOME}/MyDocuments/Coding \
${HOME}/MyDocuments/Coding/Tutorials \
${HOME}/MyDocuments/Coding/Tutorials/Python \
${HOME}/MyDocuments/Coding/Tutorials/C++ \
"

# Add GitHub ssh key
ssh-add ~/.ssh/id_ed25519_github

# Setup Rust Cargo shell tools
. "$CARGO_HOME/env"

print_success "== Completed running .bashrc (Macbook Air 2022) =="
