#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X on login
if  [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
# systemctl -q is-active graphical.target &&
