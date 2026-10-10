#!/bin/sh
# Link these dotfiles into $HOME. Safe to rerun: each link is replaced, and a real file in the way
# is moved aside to <name>.bak-<date> first. Works on macOS and Linux/WSL.
set -eu
DOT="$(cd "$(dirname "$0")" && pwd)"
STAMP=$(date +%Y%m%d)

link() { # link <file in dotfiles> <target path>
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak-$STAMP"; fi
  ln -sfn "$DOT/$1" "$2"
  echo "$2 -> $DOT/$1"
}

link zshrc         "$HOME/.zshrc"
link zprofile      "$HOME/.zprofile"
link tmux.conf     "$HOME/.tmux.conf"
link starship.toml "$HOME/.config/starship.toml"
# nvim: only when there's no config yet (WSL keeps its own clone at ~/.config/nvim).
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  echo "$HOME/.config/nvim: own config, left alone"
else
  link nvim "$HOME/.config/nvim"
fi
case "$(uname -s)" in
  Linux)  link profile "$HOME/.profile" ;;    # bash login shells; macOS uses zprofile only
  Darwin) link wezterm.lua "$HOME/.wezterm.lua" ;;
esac

# Links left behind by older layouts (renamed or retired files).
for old in "$HOME/.p10k.zsh" "$HOME/.wezterm.lua"; do
  if [ -L "$old" ] && [ ! -e "$old" ]; then rm "$old"; echo "removed dangling $old"; fi
done
