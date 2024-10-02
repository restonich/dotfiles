# User specific aliases and functions

### ls usability
alias ls='ls -h --color=auto --sort=version --group-directories-first'
alias la='ls -A'
alias ll='ls -l'
alias lal='ls -Al'
alias lla='ls -Al'

### grep colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### Display ANSI colors with less
alias less='less -R'

### Force tmux to assume the terminal supports 256 colours
alias tmux='tmux -2'

### Git helpers
alias gicm='git commit'
alias gico='git checkout'
alias gilo='git log'
alias gist='git status'
alias gisubup='git submodule update --init --recursive --force --jobs=$(nproc)'
alias gisubde='git submodule deinit --force --all'

### Program aliases
alias vi='nvim'
