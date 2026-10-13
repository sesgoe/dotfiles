# Login-shell environment for Linux machines (macOS logs in with zsh, which reads zprofile).
# symlinks.sh sources this from the end of ~/.profile, which stays the machine's own file: the OS
# default (it sources ~/.bashrc and puts ~/.local/bin on PATH) plus env blocks that fleet writes
# (github.com/sesgoe/fleet scripts/lib.sh). POSIX sh: dash runs it for `sh -l`, which is how T3 Code
# finds provider CLIs, and a failed `.` ends a dash login shell, so every source checks its file first.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
