#!/bin/sh
# Link these dotfiles into $HOME. Safe to rerun: each link is replaced, and a real file in the way
# is moved aside to <name>.bak-<date> first. Works on macOS and Linux/WSL. github.com/sesgoe/fleet runs
# it on every fleet machine (scripts/install-dotfiles.sh); the Mac runs it by hand after a pull.
set -eu
DOT="$(cd "$(dirname "$0")" && pwd)"
STAMP=$(date +%Y%m%d)

link() { # link <file in dotfiles> <target path>
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak-$STAMP"; fi
  ln -sfn "$DOT/$1" "$2"
  echo "$2 -> $DOT/$1"
}

# source_from <file in dotfiles> <rc file>: end <rc file> with one line that sources ours. ~/.profile
# and ~/.bashrc stay real files, because other tools write env blocks into them (fleet's lib.sh). A
# link there got rewritten into a plain copy by such a tool, and an append glued onto the copy's
# unterminated last line broke every `sh -l` on the controller (2026-10-11).
source_from() {
  line="[ -f \"$DOT/$1\" ] && . \"$DOT/$1\"  # sesgoe/dotfiles"
  # An older layout linked the rc file here: start over from the OS default.
  if [ -L "$2" ]; then rm "$2"; cp "/etc/skel/$(basename "$2")" "$2" 2>/dev/null || :; fi
  touch "$2"
  if ! grep -qxF "$line" "$2"; then
    tmp=$(mktemp)
    grep -v ' # sesgoe/dotfiles$' "$2" >"$tmp" || :   # a line from a clone that has moved
    if [ -s "$tmp" ] && [ -n "$(tail -c1 "$tmp")" ]; then echo >>"$tmp"; fi
    printf '%s\n' "$line" >>"$tmp"
    cat "$tmp" >"$2" && rm "$tmp"   # cat, not mv: keeps the file's mode and owner
  fi
  echo "$2 sources $DOT/$1"
}

# zsh is the login shell on the controller and the Mac; fleet boxes log in with bash and have no zsh.
if command -v zsh >/dev/null; then
  link zshrc    "$HOME/.zshrc"
  link zprofile "$HOME/.zprofile"
fi
link tmux.conf     "$HOME/.tmux.conf"
link starship.toml "$HOME/.config/starship.toml"
# nvim: only when there's no config yet (WSL keeps its own clone at ~/.config/nvim).
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  echo "$HOME/.config/nvim: own config, left alone"
else
  link nvim "$HOME/.config/nvim"
fi
case "$(uname -s)" in
  Linux)  # macOS logs in with zsh only
    source_from profile "$HOME/.profile"   # sh and bash login shells
    source_from bashrc  "$HOME/.bashrc"    # interactive bash
    ;;
  Darwin) link wezterm.lua "$HOME/.wezterm.lua" ;;
esac

# Links left behind by older layouts (renamed or retired files).
for old in "$HOME/.p10k.zsh" "$HOME/.wezterm.lua"; do
  if [ -L "$old" ] && [ ! -e "$old" ]; then rm "$old"; echo "removed dangling $old"; fi
done
