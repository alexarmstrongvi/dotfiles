# Brew
brew update # sync base of available packages and versions
brew upgrade # install upgrades
brew cleanup --prune=1 -s
brew doctor
brew missing

# UV
uv tool upgrade --all

# Anaconda
conda update conda
# conda update --all
conda clean --all
# Repeat in each environment

## Manual
# Open neovim and run...
# :Lazy
#   U - Update all outdated packages
# :Mason 
#   C - Check for new versions (all packages) 
#   U - Update all outdated packages
# :checkhealth
