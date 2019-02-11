# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot="$(cat /etc/debian_chroot)"
fi

PS1='[\u@\h \W]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)  ;;
esac

# enable color support of ls
if [[ -x /usr/bin/dircolors ]]; then
    [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi
if [[ -d ~/.aliases/ ]]; then
    for alias_file in ~/.aliases/*; do
        source "$alias_file"
    done
    unset alias_file
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
      source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
      source /etc/bash_completion
    fi
fi

# Don't move this to a separate script; caused issues.
add_ssh_keys() {
    declare ssh_key_names="$@"
    for key_name in "$ssh_key_names"; do
        local key="$HOME"/.ssh/"$key_name"
        if [[ -f "$key" ]]; then
            chmod 600 "$key"
        fi
    done
    eval "$(keychain --eval --quiet $@)"
}

source /usr/share/doc/pkgfile/command-not-found.bash

export EDITOR="vim"

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/share/powerline/bindings/bash/powerline.sh
if [[ -n "$SSH_CONNECTION" ]]; then
    neofetch
    #changing lang fixes vim powerline
    export LANG="en_US.UTF-8"
fi
if [[ "$TERM" == "linux" ]] || [[ -n "$SSH_CONNECTION" ]]; then
    export POWERLINE_CONFIG_OVERRIDES='ext.vim.top_theme="ascii";common.default_top_theme="ascii"'
else
    export POWERLINE_CONFIG_OVERRIDES=''
fi
#need to start powerline-daemon with unicode LANG regardless
LANG="en_US.UTF-8" powerline-daemon -q

# disable Ctrl-S
stty -ixon

