alias t='terraform'
alias k=kubectl
alias kubectx='kubectl ctx'
alias kctx='kubectl ctx'
alias kubens='kubectl ns'
alias kns='kubectl ns'

alias open='xdg-open'
alias tp='terraform plan -out=plan.out'
alias tv='terraform show -json plan.out > plan.json  && terraform-visual --plan plan.json && xdg-open terraform-visual-report/index.html'
alias tpv='terraform plan -out=plan.out && terraform show -json plan.out > plan.json  && terraform-visual --plan plan.json && xdg-open terraform-visual-report/index.html'
alias tap='terraform apply plan.out'
alias i='sudo apt install'
alias c='code .'


alias gp='git push origin main'
alias gcm='git commit -m'
alias gt='git status'
alias gd='git diff'


alias v='vagrant'
alias ed='code ~/.dotfiles'


# Issue that work for add path for Fish Shell
# https://github.com/fish-shell/fish-shell/issues/527
set PATH $HOME/.arkade/bin/ $PATH


# Adding Golango to Fish Shell
set -x GOPATH $HOME/go
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
