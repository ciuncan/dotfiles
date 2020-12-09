#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
############################

########## Variables

dir=$(pwd)                            # dotfiles directory

olddir=$HOME/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc gitconfig psqlrc vimperatorrc vimrc inputrc ideavimrc i3 i3blocks.conf zshrc emacs oh-my-zsh Xresources.d config/rofi config/starship.toml"
##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p "$olddir"
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd "$dir" || exit
echo "done"

# create dotfiles_old in homedir
echo -n "Cloning out oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the $HOME/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from $HOME to $olddir"
    mv "$HOME/.$file" "$HOME/dotfiles_old/"
    echo "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/.$file"
done

[[ -f "$HOME/.Xresources" ]] && touch "$HOME/.Xresources"

cd "$dir" || exit

find Xresources.d -type f | while read -r line; do
  grep "#include \".$line\"" ~/.Xresources || \
    echo "#include \".$line\"" >> ~/.Xresources
done

#install vundle for vim:
rm -rf ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/.oh-my-zsh || exit

#install zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

#zsh-completions
git clone git://github.com/zsh-users/zsh-completions.git


mkdir -p ~/.zsh/completion

fpath=(~/.zsh/completion "$fpath")
autoload -Uz compinit && compinit -i
