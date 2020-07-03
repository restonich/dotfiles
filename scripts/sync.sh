#!/usr/bin/env bash

DOTFILES=$(find ./ -path "./.git" -prune -o -name "*.sh" -o -name "README.md" -o -type f -print | sed "s/\.\///g")
OPT=${1:-help}

case $OPT in
t*)
  for i in $DOTFILES ; do
    cp "$i" "$HOME/$i"
  done
  ;;
f*)
  for i in $DOTFILES ; do
    cp "$HOME/$i" "$i"
  done
  ;;
h*)
  echo "\
Usage:
  ./sync.sh to    - moves files to host
            from  - moves files from host
            help  - displays this help"
  ;;
esac
