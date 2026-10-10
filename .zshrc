# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
 zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search rust zsh-vi-mode ssh-agent)

zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent identities ses-github-wsl

# Docker Desktop links this completion into WSL, but the target only exists once Docker Desktop
# is running; a dangling link makes compinit print errors (and trips p10k's instant prompt).
[[ -e /usr/share/zsh/vendor-completions/_docker ]] || fpath=(${fpath:#/usr/share/zsh/vendor-completions})

# jj completions, cached: generating them on every start costs a subprocess.
mkdir -p "$ZSH/cache/completions"
if [[ ! -s $ZSH/cache/completions/_jj || $commands[jj] -nt $ZSH/cache/completions/_jj ]]; then
  jj util completion zsh >| "$ZSH/cache/completions/_jj"
fi

source $ZSH/oh-my-zsh.sh
# bash-style `complete` (aws-sso, peon) needs bashcompinit; oh-my-zsh already ran compinit.
autoload -U +X bashcompinit && bashcompinit

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

export PNPM_HOME="/home/sesgoe/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

. "$HOME/.cargo/env"

export PATH="/home/sesgoe/.local/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias cat='bat'
alias ls='exa'
alias k='kubectl'
alias tel='telepresence'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/home/sesgoe/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
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

eval "$(atuin init zsh)"


. "$HOME/.atuin/bin/env"

# add Pulumi to the PATH
export PATH=$PATH:/home/sesgoe/.pulumi/bin

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"
. "/home/sesgoe/.deno/env"

setopt NO_CORRECT
setopt NO_CORRECT_ALL
# BEGIN_AWS_SSO_CLI

# AWS SSO requires `bashcompinit` which needs to be enabled once and
# only once in your shell.  Hence we do not include the two lines:
#
# autoload -Uz +X compinit && compinit
# autoload -Uz +X bashcompinit && bashcompinit
#
# If you do not already have these lines, you must COPY the lines 
# above, place it OUTSIDE of the BEGIN/END_AWS_SSO_CLI markers
# and of course uncomment it

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

source <(switcher init zsh)
export PATH="/home/sesgoe/.config/herd-lite/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/sesgoe/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# helpful for description editing for jj
export EDITOR=nvim

# add datagrip to path
export PATH="/opt/DataGrip-2025.1.3/bin:$PATH"

# peon-ping quick controls
alias peon="bash /home/sesgoe/.claude/hooks/peon-ping/peon.sh"
[ -f /home/sesgoe/.claude/hooks/peon-ping/completions.bash ] && source /home/sesgoe/.claude/hooks/peon-ping/completions.bash

