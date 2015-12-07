#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
############################

########## Variables

dir=$HOME/dotfiles                    # dotfiles directory

olddir=$HOME/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc i3 ctags gitconfig psqlrc vimperatorrc vimrc inputrc ideavimrc vim zsh zshrc emacs oh-my-zsh private Xresources gtkrc-2.0 i3status.conf config/gtk-3.0/settings.ini " # oh-my-fish config/fish config/dunst/dunstrc
##########

#mkdir -p $HOME/.config/dunst

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# create dotfiles_old in homedir
echo -n "Cloning out oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the $HOME/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from $HOME to $olddir"
    mv $HOME/.$file $HOME/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $HOME/.$file
done

function install_zsh {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/michaeljsmalley/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh

#install vundle for vim:
rm -rf ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#install zsh-syntax-highlighting
cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

#zsh-completions
git clone git://github.com/zsh-users/zsh-completions.git


s_loc=~/.oh-my-zsh/s
mkdir -p "$s_loc" && cd "$s_loc"
git clone https://github.com/haosdent/s "$s_loc"
chmod +x "$s_loc/s.sh"

mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/sdurrheimer/docker-compose-zsh-completion/master/_docker-compose >| ~/.zsh/completion/_docker-compose

mkdir -p ~/bin
mkdir ~/.ammonite; curl -L -o ~/.ammonite/predef.scala http://git.io/vnnBy
curl -L -o ~/bin/amm http://git.io/vnnBX; chmod +x ~/bin/amm

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
