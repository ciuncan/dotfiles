set -x PATH ~/bin /usr/local/bin /usr/local/share/npm/bin $PATH ~/local/bin

# sometimes TMUX can get confused about whether unicode is supported to draw
# lines or not. tmux may draw x and q instead, or default to - and | which is
# ascii. This also allows other programs to use nice UTF-8 symbols, such as
# NERDtree in vim. So very awesome.
set -x LANG=en_GB.utf8

# TERM TYPE Inside screen/tmux, it should be screen-256color -- this is
# configured in .tmux.conf.  Outside, it's up to you to make sure your terminal
# is configured to provide the correct, 256 color terminal type. For putty,
# it's putty-256color (which fixes a lot of things) and otherwise it's probably
# something ilike xterm-256color. Most, if not all off the terminals I use
# support 256 colors, so it's safe to force it as a last resort, but warn.
if begin; test -z $TMUX ; and test (tput colors) -ne 256; end
	set -x TERM xterm-256color
	set_color red
	echo "> TERM '$TERM' is not a 256 colour type! Overriding to xterm-256color. Please set. EG: Putty should have putty-256color."
	set_color normal
end


# AUTOMATIC TMUX
# must not launch tmux inside tmux (no memes please)
test -z $TMUX
	# installed?
	and which tmux > /dev/null
	# only attach if single session
	and test (tmux list-sessions | wc -l ^ /dev/null) -eq 1
	# don't attach if already attached elsewhere
	and test (tmux list-clients | wc -l ^ /dev/null) -eq 0
	# terminal must be wide enough
	and test (tput cols) -gt 119
	# only then is is safe to assume it's OK to jump in
	and tmux attach


# totally worth it
if not test -d ~/.config/fish/generated_completions/
	echo "One moment..."
	fish_update_completions
end


# vim -X = don't look for X server, which can be slow
set -x EDITOR 'vim -X'

set -x HOSTNAME (hostname)


# if you call a different shell, this does not happen automatically. WTF?
set -x SHELL (which fish)

# available since 4.8.0
set -x GCC_COLORS 1

# alias is just a wrapper for creating a function
# aliases shared between fish and bash
. ~/.aliases

# fish specific aliases
alias tm 'test -z $TMUX; and tmux a ; or tmux'

function cd
	builtin cd $argv
		and ls
end

test -x /usr/bin/keychain
	and test -r ~/.ssh/id_rsa
	and eval (keychain --quiet --eval ~/.ssh/id_rsa)

# these functions are too small to warrant a separate file
function fish_greeting
	echo \n\> Welcome to $HOSTNAME, $USER. Files in $PWD are:\n
	ls
	echo -e "\n> Shell is $SHELL"
end


function fish_title --description 'Set terminal (not tmux) title'
	# title of terminal
	echo $HOSTNAME
end

function fish_tmux_title --description "Set the tmux window title"
	# to a clever shorthand representation of the current dir. minus whitespace
	echo $PWD | sed s/[^a-zA-Z0-9\/]/-/g | grep -oE '[^\/]+$'
end

function fish_set_tmux_title --description "Sets tmux pane title to output of fish_tmux_title, with padding" --on-variable PWD
	# title of tmux pane, must be separate to fish_title
	# only run this if tmux is also running
	test -z $TMUX
		or printf "\\033k%s\\033\\\\" (fish_tmux_title)
end

function fish_prompt --description 'Write out the prompt'
	echo -n -s \n (set_color green) $USER @ $HOSTNAME (set_color normal)\
	' ' (set_color --bold blue) (pwd) (set_color normal)\
	(set_color yellow) (__fish_git_prompt) (set_color normal)\
	\n\$ ' '
end

# initially set title
fish_set_tmux_title

status --is-login; and status --is-interactive; and exec byobu-launcher

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish

status --is-interactive; or exit 0

