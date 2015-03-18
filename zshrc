## Now, we'll give a few examples of what you might want to use in your
## .zshrc.local file (just copy'n'paste and uncomment it there):

zmodload zsh/complist
## ZLE tweaks ##

## use the vi navigation keys (hjkl) besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

## set command prediction from history, see 'man 1 zshcontrib'
#is4 && zrcautoload predict-on && \
zle -N predict-on         && \
zle -N predict-off        && \
bindkey "^X^Z" predict-on && \
bindkey "^Z" predict-off

## press ctrl-q to quote line:
mquote () {
      zle beginning-of-line
      zle forward-word
      # RBUFFER="'$RBUFFER'"
      RBUFFER=${(q)RBUFFER}
      zle end-of-line
}
zle -N mquote && bindkey '^q' mquote

## define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
WORDCHARS='${WORDCHARS:s@/@}'

# just type '...' to get '../..'
rationalise-dot() {
local MATCH
if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
  LBUFFER+=/
  zle self-insert
  zle self-insert
else
  zle self-insert
fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

bindkey '\eq' push-line-or-edit

## some popular options ##

## add `|' to output redirections in the history
setopt histallowclobber

## warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

## don't warn me about bg processes when exiting
#setopt nocheckjobs

## alert me if something failed
setopt printexitvalue

## with spelling correction, assume dvorak kb
#setopt dvorak

## Allow comments even in interactive shells
setopt interactivecomments


## compsys related snippets ##

## changed completer settings
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix

## another different completer setting: expand shell aliases
zstyle ':completion:*' completer _expand_alias _complete _approximate

## to have more convenient account completion, specify your logins:
my_accounts=(
 ceyhuncanu@gmail.com
 ceyhuncan.ulker@stu.bahcesehir.edu.tr
 can.ulker@bahcesehir.edu.tr
)
#other_accounts=(
# {fred,root}@foo.invalid
# vera@bar.invalid
#)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
zstyle ':completion:*:other-accounts' users-hosts $other_accounts

## telnet on non-default ports? ...well:
## specify specific port/service settings:
#telnet_users_hosts_ports=(
#  user1@host1:
#  user2@host2:
#  @mail-server:{smtp,pop3}
#  @news-server:nntp
#  @proxy-server:8000
#)
zstyle ':completion:*:*:telnet:*' users-hosts-ports $telnet_users_hosts_ports

## the default grml setup provides '..' as a completion. it does not provide
## '.' though. If you want that too, use the following line:
zstyle ':completion:*' special-dirs true

## aliases ##

## translate
#alias u='translate -i'

## ignore ~/.ssh/known_hosts entries
#alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -o "PreferredAuthentications=keyboard-interactive"'


## global aliases (for those who like them) ##

alias -g '...'='../..'
alias -g '....'='../../..'
alias -g BG='& exit'
alias -g C='|wc -l'
alias -g G='|grep'
alias -g H='|head'
alias -g Hl=' --help |& less -r'
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# favorites: agnoster, avit, bira, bureau, mortalscumbag, wedisagree, ys
ZSH_THEME="wedisagree"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git
         git-flow
         gitignore
         npm
         vi-mode
         syntax-highlighting
         history-substring-search
         web-search
         debian
         scala
         sbt
        )

source $ZSH/oh-my-zsh.sh

export LANG=en_US.utf8
export LANGUAGE=
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.utf8
export LC_TIME=en_US.utf8
export LC_COLLATE="en_US.utf8"
export LC_MONETARY=en_US.utf8
export LC_MESSAGES="en_US.utf8"
export LC_PAPER=en_US.utf8
export LC_NAME=en_US.utf8
export LC_ADDRESS=en_US.utf8
export LC_TELEPHONE=en_US.utf8
export LC_MEASUREMENT=en_US.utf8
export LC_IDENTIFICATION=en_US.utf8
export LC_ALL=


export DROPB="$HOME/Dropbox"
export DPROJ="$DROPB/Projects"

#export DART_SDK="$HOME/Apps/dev/dart/dart-sdk"
#export SBT_HOME=$HOME/Apps/sbt
#export SCALA_HOME=$HOME/Apps/scala-2.9.2
#export SCALDING_HOME=$HOME/Apps/scalding
#export HADOOP_PREFIX=$HOME/Apps/hadoop
#export HIVE_HOME=$HOME/apps/hive
#export JAVA_HOME=/usr/lib/jvm/java-7-oracle

# Customize to your needs...
export PATH=$PATH:$HOME/bin:$DPROJ/scripts/bash

alias gvim='gvim -p --remote-tab-silent'
alias clip='xclip -selection clipboard'
alias top="htop"
alias du="ncdu"
alias df="pydf"

#set vi mode
#bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


function mkc () {
    mkdir -p "$@" && cd "$@"
}


# function Extract for common file formats
# see: https://github.com/xvoland/Extract

function extract {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f "$1" ] ; then
      NAME=${1%.*}
      mkdir $NAME && cd $NAME
      case "$1" in
        *.tar.bz2)   tar xvjf ../"$1"    ;;
        *.tar.gz)    tar xvzf ../"$1"    ;;
        *.tar.xz)    tar xvJf ../"$1"    ;;
        *.lzma)      unlzma ../"$1"      ;;
        *.bz2)       bunzip2 ../"$1"     ;;
        *.rar)       unrar x -ad ../"$1" ;;
        *.gz)        gunzip ../"$1"      ;;
        *.tar)       tar xvf ../"$1"     ;;
        *.tbz2)      tar xvjf ../"$1"    ;;
        *.tgz)       tar xvzf ../"$1"    ;;
        *.zip)       unzip ../"$1"       ;;
        *.Z)         uncompress ../"$1"  ;;
        *.7z)        7z x ../"$1"        ;;
        *.xz)        unxz ../"$1"        ;;
        *.exe)       cabextract ../"$1"  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "'$1' - file does not exist"
    fi
  fi
}

function rand-word {
  local count=${1:-4}
  shuf -n $count /usr/share/dict/words
}

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(~/.oh-my-zsh/zsh-completions/src $fpath)
rm -f ~/.zcompdump; compinit
source ~/.oh-my-zsh/z/z.sh
source ~/.oh-my-zsh/s/s.sh

# Make Zsh use command-not-found package suggestions:
source /etc/zsh_command_not_found

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
