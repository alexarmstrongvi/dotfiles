################################################################################
# Script to install VS Code extensions
#
# Get started with code 
# >> code --list-extensions > install_extensions.sh
# Note that some packages install their own extensions
################################################################################
# Text editing
code --install-extension stkb.rewrap

# Python
code --install-extension ms-python.python
# code --install-extension ms-python.isort
code --install-extension charliermarsh.ruff # Ruff linter and formatter
code --install-extension tamasfe.even-better-toml # TOML syntax highlighting

# Jupyter notebooks
code --install-extension ms-toolsai.jupyter

# Git
code --install-extension eamodio.gitlens
code --install-extension mhutchie.git-graph

# C++ & CMake
code --install-extension ms-vscode.cpptools-extension 

# Vim mode
code --install-extension vscodevim.vim

# Code alignment using regex
code --install-extension janjoerke.align-by-regex


