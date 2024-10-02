################################################################################
# Custom config                                                                #
################################################################################

# Shell format and color
BLACK="\[$(tput setaf 0)\]"
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
MAGENTA="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"
BOLD="\[$(tput bold)\]"
RESET="\[$(tput sgr0)\]"

PS1_DOCKER=""
if [ -n "$DOCKER_RUNNING" ]; then
    PS1_DOCKER="${CYAN}${BOLD}(DOCKER)${RESET}"
fi

PS1_RANGER=""
if [ -n "$RANGER_LEVEL" ]; then 
    PS1_RANGER="${YELLOW}${BOLD}(ranger)${RESET}"
fi

PROMPT_DIRTRIM=3
PROMPT_COMMAND=""
PS1="${PS1_DOCKER}${PS1_RANGER}[${BOLD}${BLUE}\w${RESET}]\$ "

################################################################################

# Enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

################################################################################

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################################################################################

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add python venv
if [ -d "$HOME/.venv/bin" ] ; then
    PATH="$HOME/.venv/bin:$PATH"
fi

################################################################################

# Environment variables
export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
