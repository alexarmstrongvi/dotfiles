################################################################################
# Script to install VS Code extensions (this can be run by bash or powershell)
#
# Get started with code 
# >> code --list-extensions > install_extensions.sh
# Note that some packages install their own extensions
################################################################################
# Text editing
code --install-extension dnut.rewrap-revived

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
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode.cpptools-themes
code --install-extension ms-vscode.cmake-tools
code --install-extension llvm-vs-code-extensions.vscode-clangd

# Vim mode
code --install-extension vscodevim.vim

# Code alignment using regex
code --install-extension janjoerke.align-by-regex

# Microsoft
code --install-extension ms-vscode.powershell