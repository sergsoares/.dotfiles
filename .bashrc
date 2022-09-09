#fish

#PS1=`whoami`' $PWD \n~> ' ; export PS1
PS1='${PWD##*/} $ '

alias edit="vim ~/.dotfiles/.bashrc"
alias e="vim ~/.dotfiles/.bashrc"
alias t=terraform
alias tap="terraform apply"
alias ti="terraform init"
alias k=kubectl
alias l="ls -lha"
alias g="lazygit"
alias gs="git status"
alias gt="git tag"

alias b=bash
alias p=pwd

alias d=dig
alias wkpo="watch kubectl get pods"
alias kpo="kubectl get pods"
alias wkl="kubectl logs --follow"
alias kgn="kubectl get nodes"
alias wkgn="kubectl get nodes"
alias al="aws sso login"
alias ksn="kubectl config set-context --current --namespace"

kube() {
  kubectl config use-context $(kubectl config get-contexts -o name | fzf)
  kubectl config set-context --current --namespace="${1:-default}"
  #PS1='${PWD##*/} [$(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ '
  PS1='${PWD##*/} [$(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ '
}

kn() {
  kubectl config set-context --current --namespace=$(kubectl get namespaces | cut -d ' ' -f1 | fzf)
}

kdn() {
  kubectl describe node $(kubectl get nodes | fzf | cut -d " " -f1)
}

kdp() {
  kubectl describe pod $(kubectl get pods | fzf | cut -d " " -f1)
}

ked() {
  kubectl edit deploy $(kubectl get deploy | fzf | cut -d " " -f1)
}

kl() {
  kubectl logs $(kubectl get pods | fzf | cut -d " " -f1)
}

kdd() {
  kubectl describe daemonset $(kubectl get daemonset | fzf | cut -d " " -f1)
}

unkube() {
  kubectl config unset current-context
}

#PS1='${PWD##*/} [$(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ '

k8s_context(){
  kubectl config current-context 2>/dev/null
}
#PS1='${PWD##*/} [$(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ '

source ~/.pwork

export PATH=/usr/local/bin:$PATH
export PATH=~/.dotfiles/tasks:$PATH
