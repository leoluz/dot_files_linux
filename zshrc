export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$DOT_FILES_HOME/bin:$PATH"
export DOT_FILES_HOME="$HOME/dot_files_macos"
export GOPATH="$HOME/dev/go"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export GPG_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"
[ -f $HOME/.ad_profile ] && source $HOME/.ad_profile
[ -f $HOME/.dw_profile ] && source $HOME/.dw_profile
[ -f $HOME/.it_profile ] && source $HOME/.it_profile
[ -f $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm
[ -d $HOME/.krew/bin ] && export PATH="${HOME}/.krew/bin:${PATH}"
[ -d $HOME/dev/bin ] && export PATH="${HOME}/dev/bin:${PATH}"
[ -d $GOPATH/bin ] && export PATH="${GOPATH}/bin:${PATH}"
[ -d $HOME/dev/nvim-osx64 ] && export PATH="${HOME}/dev/nvim-osx64/bin:${PATH}"
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
[ -d $HOME/bin/google-cloud-sdk/bin ] && export PATH="${HOME}/bin/google-cloud-sdk/bin:${PATH}"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -d $HOME/bin/codeql ] && export PATH="$HOME/bin/codeql:${PATH}"
type nvim >/dev/null 2>&1 && export EDITOR="nvim"

# Configures homebrew completions
#if type brew &>/dev/null; then
    #echo "has homebrew"
    #fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
    #FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
#fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="refined"
ZSH_THEME="kolo"
#ZSH_THEME="amuse"
#ZSH_THEME="avit"
#ZSH_THEME="robbyrussell"
#ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# If set to an empty array, this variable will have no effect.
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
ZSH_CUSTOM="$HOME/dot_files_macos/zsh-custom"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    github
)

#if [ -f $HOME/dot_files_macos/git-completion.bash ]; then
    #source $HOME/dot_files_macos/git-completion.bash
#fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# gm will checkout the upstream ('origin' if 'upstream' is not available) HEAD branch, fetch remote and rebase
function gm() {
    if [[ $(git remote) =~ "upstream$" ]]; then
        REMOTE=upstream
    else
        REMOTE=origin
    fi
    MAIN=$(git remote show $REMOTE | awk '/HEAD branch/ {print $NF}')
    git checkout $MAIN
    git fetch $REMOTE
    git rebase $REMOTE/$MAIN
}
#
# gr will fetch the upstream HEAD branch rebase
function gr() {
    if [[ $(git remote) =~ "upstream$" ]]; then
        REMOTE=upstream
    else
        REMOTE=origin
    fi
    MAIN=$(git remote show $REMOTE | awk '/HEAD branch/ {print $NF}')
    git fetch $REMOTE
    git rebase $REMOTE/$MAIN
}
unalias gm
unalias gr
# alias swagger="docker run --rm -it -e GOPATH=$GOPATH:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"
#
capture_osx() {
    sudo dtrace -p "$1" -qn '
        syscall::write*:entry
        /pid == $target && arg0 == 1/ {
            printf("%s", copyinstr(arg1, arg2));
        }
    '
}

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias luamake=/Users/lalmeida1/dev/git/lua-language-server/3rd/luamake/luamake

# get ArgoCD controller pid
alias cpid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep repo-server | grep -v dex-server | awk '{print \$2}'"
# get ArgoCD repo pid
alias rpid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep -v dex-server | grep '\-\-port' | awk '{print \$2}'"
# get ArgoCD CMP pid
alias ppid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep config-dir-path | awk '{print \$2}'"
# get ArgoCD API server pid
alias apid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep '\-\-disable-auth' | awk '{print \$2}'"

type fastfetch >/dev/null 2>&1 && fastfetch
