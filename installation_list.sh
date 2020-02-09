#! /bin/bash

sudo pacman -Sy \
  jdk11-openjdk
  xclip \
  ripgrep \
  fzf \
  deluge \
  openjdk-11-jdk \
  keepassxc \
  sbt \
  nodejs \
  rustup \
  telegram-desktop \
  shellcheck \
  remmina \
  libvncserver \
  freerdp

sudo npm i -g diff-so-fancy tldr

# Install rust
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
code --install-extension timonwong.shellcheck

# install [ammonite-repl](ammonite.io)
