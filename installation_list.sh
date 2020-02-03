#! /bin/bash

sudo apt update
sudo apt install \
  xclip \
  ripgrep \
  fzf \
  deluge \
  openjdk-11-jdk \
  keepassxc \
  sbt \
  nodejs


# Install nodejs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs
sudo npm i -g diff-so-fancy tldr

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-src rls
cargo install exa

# Install vscode
sudo snap install code --classic
code --install-extension scalameta.metals
code --install-extension eamodio.gitlens
code --install-extension rust-lang.rust
code --install-extension vscodevim.vim
code --install-extension humao.rest-client
code --install-extension mechatroner.rainbow-csv
code --install-extension 2gua.rainbow-brackets
code --install-extension oderwat.indent-rainbow


# Install Telegram
sudo snap install telegram-desktop

# Install LLVM & clang
sudo apt install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python-clang
