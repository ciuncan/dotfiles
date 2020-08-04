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
# favorites=(3den crunch jonathan)
ZSH_THEME="eastwood"

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
         gitignore
         archlinux
         docker
         vi-mode
         history-substring-search
         colored-man-pages
         npm
         mvn
         aws
         golang
         scala
         sbt
         z
        )

source $ZSH/oh-my-zsh.sh

mkdir -p $HOME/.logs
export PROMPT_COMMAND='[ $(id -u) -ne 0 \] && echo $(date +%Y-%m-%d.%H:%M:%S) $(pwd) $(fc -ln -1) >>| ~/.logs/shell-history-$(date +%Y-%m-%d).log'
prmptcmd() { eval $PROMPT_COMMAND }
precmd_functions=(prmptcmd)

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"

# Customize to your needs...
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/dev/oss/dotty/bin

alias gdd='git difftool --dir-diff'
alias gvim='gvim -p --remote-tab-silent'
alias clip='xclip -selection clipboard'
alias paste='xclip -selection cliplboard -o'
alias top="htop"
alias du="ncdu"
alias df="pydf"
alias lsf="less +F --follow-name"
alias jql="jq . -C | less"

command -v exa >/dev/null 2>&1 && alias ls="exa" && alias ll="exa -laF"

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'

alias more=less
alias vi=vim
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

set vi mode
#bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


function mkc {
    mkdir -p "$@" && cd "$@"
}

function ssh-fingerprints {
  keys=$1
  if [ -f $keys ]; then
    keys=`cat $keys`
  fi
  while read -r line; do
    file=`mktemp`
    echo $line >| $file
    ssh-keygen -lf $file
    rm $file
  done <<< "$keys"
}

# see: https://gist.github.com/earthgecko/3089509
function rand-string {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

function rand-word {
  local count=${1:-4}
  shuf -n $count /usr/share/dict/cracklib-small
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(~/.oh-my-zsh/zsh-completions/src $fpath)
source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k
autoload -Uz compinit
compinit

export LC_ALL=en_US.UTF-8

export JAVA_HOME="/usr/lib/jvm/default"
export JDK_HOME="/usr/lib/jvm/default"

export EDITOR="vim"
export BROWSER=`which firefox-developer-edition`

host_if_remote=$([ -n "$SSH_CLIENT" ] && echo "$HOST " || echo "")
export PS1="$host_if_remote$PS1"

function wake_at {
  mac_address='e0:d5:5e:a0:1e:77'
  wol "$mac_address"
}

function switch_jdk {
  version="java-$1-openjdk"
  status_output="$(archlinux-java status)"
  if [[ "$status_output" == *"$version"* ]]; then
    sudo archlinux-java set "$version"
  else
    echo "Version you entered is not found: $version"
    echo "$status_output"
    echo "Usage"
    echo "In order to switch to using JDK 14 (java-14-openjdk), issue following command:"
    echo "switch_jdk 14"
  fi
}
