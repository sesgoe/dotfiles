# Interactive bash on Linux: the fleet boxes' login shell (the controller and the Mac use zsh: zshrc).
# symlinks.sh sources this from the end of ~/.bashrc, which stays the machine's own file: the OS
# default (history, prompt, completion, ls colors) plus env blocks that fleet writes at its top
# (github.com/sesgoe/fleet scripts/lib.sh). So this holds only what the OS default lacks, and every
# tool is optional: boxes install fewer tools than the controller.
# Agent shells need nothing here: bash already passes unmatched globs through, keeps `=word` a word,
# and splits an unquoted $VAR (what zshrc's CLAUDECODE section sets for zsh).
case $- in *i*) ;; *) return ;; esac

# History: long, timestamped, and written as each command finishes, so tmux panes and SSH sessions
# don't overwrite each other's.
HISTSIZE=100000
HISTFILESIZE=200000
HISTTIMEFORMAT='%F %T  '
shopt -s histappend
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

for EDITOR in nvim vim vi; do command -v "$EDITOR" >/dev/null && break; done
export EDITOR

# direnv: a repo's allowed .envrc loads its dev shell (devenv) on cd.
command -v direnv >/dev/null && eval "$(direnv hook bash)"
# Starship where it's installed (the zsh prompt); otherwise the OS default user@host:dir prompt.
command -v starship >/dev/null && eval "$(starship init bash)"
true
