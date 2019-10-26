# Environment variables
export VISUAL=nvim
export EDITOR=nvim

# Start X on login
if systemctl -q is-active graphical.target &&  [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
