#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f "/etc/bashrc" ]; then
  source "/etc/bashrc"
fi

# User specific aliases and functions
alias ls='ls -hF --color=auto --sort=version --group-directories-first'
alias la='ls -A'
alias ll='ls -l'
alias lal='ls -Al'
alias lla='ls -Al'

alias cp='cp -v'

alias grep='grep --color=auto'

# Force tmux to run in true color
#alias tmux='tmux -2'

