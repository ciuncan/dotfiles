#! /bin/bash

sudo pacman -Sy \
  jdk8-openjdk \
  xclip \
  ripgrep \
  fzf \
  deluge \
  firefox-developer-edition \
  keepassxc \
  sbt \
  nodejs-lts-erbium \
  npm \
  jq \
  docker \
  docker-compose \
  kubectl \
  helm \
  rustup \
  telegram-desktop \
  ghc \
  cabal-install \
  happy \
  alex \
  haskell-haddock-library \
  dhall \
  shellcheck \
  remmina \
  libvncserver \
  ttf-jetbrains-mono \
  yay \
  pacui \
  exa \
  bat \
  alacritty \
  net-tools \
  diff-so-fancy \
  tldr \
  i3blocks \
  i3lock-color \

sudo pacman -Sy \
  jdk-openjdk jdk11-openjdk

# Install aur packages
yay -S \
  native-image-jdk11-bin \
  bloop \
  ammonite \
  dhall-lsp-server-bin \
  visual-studio-code-bin \
  i3lock-fancy-git \
  i3blocks-contrib \
  starship \

# Install global npm packages
# sudo npm i -g diff-so-fancy tldr

# Install rust
rustup component add rust-src rls

# Install vscode
code --install-extension 13xforever.language-x86-64-assembly
code --install-extension 2gua.rainbow-brackets
code --install-extension bmuskalla.vscode-tldr
code --install-extension bungcip.better-toml
code --install-extension eamodio.gitlens
code --install-extension formulahendry.code-runner
code --install-extension humao.rest-client
code --install-extension James-Yu.latex-workshop
code --install-extension mathiasfrohlich.Kotlin
code --install-extension matklad.rust-analyzer
code --install-extension mechatroner.rainbow-csv
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension nyxiative.rust-and-friends
code --install-extension oderwat.indent-rainbow
code --install-extension redhat.java
code --install-extension redhat.vscode-yaml
code --install-extension RReverser.llvm
code --install-extension scala-lang.scala
code --install-extension scalameta.metals
code --install-extension serayuzgur.crates
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension timonwong.shellcheck
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-test
code --install-extension vscjava.vscode-maven
code --install-extension vscodevim.vim
