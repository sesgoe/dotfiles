# zsh config for every machine (macOS and Linux/WSL). Linked to ~/.zshrc by symlinks.sh.
# Shared settings first, then one section per OS. Prompt: Starship (starship.toml).

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""   # Starship draws the prompt (end of file)
zstyle ':omz:update' mode reminder
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search rust zsh-vi-mode ssh-agent)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
case $OSTYPE in
  darwin*) zstyle :omz:plugins:ssh-agent identities id_ed25519 ;;
  *)       zstyle :omz:plugins:ssh-agent identities ses-github-wsl ;;
esac

# Docker Desktop (WSL) links this completion in, but the target only exists while Docker Desktop
# runs; a dangling link makes compinit print errors.
[[ -e /usr/share/zsh/vendor-completions/_docker ]] || fpath=(${fpath:#/usr/share/zsh/vendor-completions})

# jj completions, cached: generating them on every start costs a subprocess.
mkdir -p "$ZSH/cache/completions"
if (( $+commands[jj] )) && [[ ! -s $ZSH/cache/completions/_jj || $commands[jj] -nt $ZSH/cache/completions/_jj ]]; then
  jj util completion zsh >| "$ZSH/cache/completions/_jj"
fi

source $ZSH/oh-my-zsh.sh
# bash-style `complete` (aws-sso) needs bashcompinit; oh-my-zsh already ran compinit.
autoload -U +X bashcompinit && bashcompinit

[[ -f $HOME/.cargo/env ]] && . "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

alias cat='bat'
alias ls='exa'
alias k='kubectl'
alias tel='telepresence'

# nvm: loading nvm.sh costs ~300ms, so put the default Node on PATH directly (node, npm, codex
# and other global npm tools work at once) and load nvm itself only when `nvm` is first run.
export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/alias/default ]] && path=("$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin" $path)
nvm() {
  unfunction nvm
  source "$NVM_DIR/nvm.sh"
  [[ -s $NVM_DIR/bash_completion ]] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}

(( $+commands[atuin] )) && eval "$(atuin init zsh)"
[[ -f $HOME/.atuin/bin/env ]] && . "$HOME/.atuin/bin/env"

export EDITOR=nvim

# --- macOS --------------------------------------------------------------------------------
if [[ $OSTYPE == darwin* ]]; then
  export PATH="$PATH:/opt/nvim-macos-arm64/bin"
fi

# --- Linux / WSL (ses-pc-w11) ---------------------------------------------------------------
if [[ $OSTYPE == linux* ]]; then
  export PATH="$PATH:/opt/nvim-linux64/bin"

  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac

  export PATH="$PATH:$HOME/.pulumi/bin"
  export GOPATH=$HOME/go
  export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"
  [[ -f $HOME/.deno/env ]] && . "$HOME/.deno/env"
  export BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"

  setopt NO_CORRECT
  setopt NO_CORRECT_ALL

  # BEGIN_AWS_SSO_CLI
  __aws_sso_profile_complete() {
       local _args=${AWS_SSO_HELPER_ARGS:- -L error}
      _multi_parts : "($(/usr/bin/aws-sso ${=_args} list --csv Profile))"
  }

  aws-sso-profile() {
      local _args=${AWS_SSO_HELPER_ARGS:- -L error}
      if [ -n "$AWS_PROFILE" ]; then
          echo "Unable to assume a role while AWS_PROFILE is set"
          return 1
      fi

      if [ -z "$1" ]; then
          echo "Usage: aws-sso-profile <profile>"
          return 1
      fi

      eval $(/usr/bin/aws-sso ${=_args} eval -p "$1")
      if [ "$AWS_SSO_PROFILE" != "$1" ]; then
          return 1
      fi
  }

  aws-sso-clear() {
      local _args=${AWS_SSO_HELPER_ARGS:- -L error}
      if [ -z "$AWS_SSO_PROFILE" ]; then
          echo "AWS_SSO_PROFILE is not set"
          return 1
      fi
      eval $(/usr/bin/aws-sso ${=_args} eval -c)
  }

  compdef __aws_sso_profile_complete aws-sso-profile
  complete -C /usr/bin/aws-sso aws-sso
  # END_AWS_SSO_CLI

  (( $+commands[switcher] )) && source <(switcher init zsh)
  export PATH="$HOME/.config/herd-lite/bin:$PATH"
  export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
  export PATH="/opt/DataGrip-2025.1.3/bin:$PATH"
fi

# --- Agent shells ---------------------------------------------------------------------------
# Claude Code sets CLAUDECODE=1 and snapshots this shell for its Bash tool. Make it behave like a
# plain shell there: an unmatched glob passes through instead of aborting the command, `=word`
# stays a word instead of a command lookup (`echo ====`), and ls/cat are the real tools whose
# output scripts can parse.
if [[ -n $CLAUDECODE ]]; then
  setopt no_nomatch no_equals
  unalias ls cat 2>/dev/null
fi

(( $+commands[starship] )) && eval "$(starship init zsh)"   # macOS: brew install starship
