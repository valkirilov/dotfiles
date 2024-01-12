# Aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
else
    print "404: ~/.aliases not found."
fi

source "$HOME/.antigen/antigen.zsh" 

# Git
antigen use oh-my-zsh
antigen bundle arialdomartini/oh-my-git
#antigen theme arialdomartini/oh-my-git-themes oppa-lana-style
antigen theme arialdomartini/oh-my-git-themes arialdo-pathinline
#antigen theme arialdomartini/oh-my-git-themes arialdo-granzestyle

antigen apply

# Hello World message
fortune | cowsay

# NVM 
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Docker
# useful only for Mac OS Silicon M1, 
# still working but useless for the other platforms
docker() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}


