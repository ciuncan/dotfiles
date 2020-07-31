#! /bin/bash

sudo pacman -Sy \
  jdk-openjdk \
  xclip \
  ripgrep \
  fzf \
  deluge \
  keepassxc \
  sbt \
  nodejs-lts-erbium \
  npm \
  jq \
  kubectl \
  helm \
  rustup \
  telegram-desktop \
  ghc \
  cabal-install \
  happy \
  alex \
  haskell-haddock-library \
  shellcheck \
  remmina \
  libvncserver \
  ttf-jetbrains-mono \
  yay \
  pacui \

# Install aur packages
sudo yay -S bloop ammonite

# Install global npm packages
sudo npm i -g diff-so-fancy tldr

# Install rust
rustup component add rust-src rls
cargo install exa

# Install vscode
sudo snap install code --classic
code --install-extension 13xforever.language-x86-64-assembly
code --install-extension 2gua.rainbow-brackets
code --install-extension bungcip.better-toml
code --install-extension eamodio.gitlens
code --install-extension formulahendry.code-runner
code --install-extension humao.rest-client
code --install-extension james-yu.latex-workshop
code --install-extension mechatroner.rainbow-csv
code --install-extension ms-vscode-remote.remote-containers
code --install-extension oderwat.indent-rainbow
code --install-extension rreverser.llvm
code --install-extension rust-lang.rust
code --install-extension scalameta.metals
code --install-extension serayuzgur.crates
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension timonwong.shellcheck
code --install-extension vscodevim.vim
