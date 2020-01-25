#! /bin/bash

sudo apt update
sudo apt install \
  dirmngr \
  apt-transport-https \
  lsb-release \
  ca-certificates \
  vim \
  git \
  gcc \
  g++ \
  make \
  htop \
  xclip \
  curl \
  ripgrep \
  fzf \
  deluge \
  flatpak \
  openjdk-14-jdk \
  keepassx

# Install sbt
echo "deb https://dl.bintray.com/sbt/debian /" | \
  sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | \
  sudo apt-key add
sudo apt update
sudo apt install sbt

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
