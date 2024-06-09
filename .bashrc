# PS1 Shell definition
PS1='\n\n${PWD##*/} ~> '
PS1="\[\033[01;32m\]${PS1}\[\033[0m\]"

alias m=make
alias edit="vim ~/.dotfiles/.bashrc"
alias e="vim ~/.dotfiles/.bashrc"
alias t=terraform
alias tap="terraform apply"
alias ti="terraform init"
alias k=kubectl
alias kap="kubectl apply -f "
alias l="ls -1 -a"
alias g="lazygit"
alias gs="git status"
alias gt="git tag"
#alias ls=exa

alias b=bash
alias path="pwd | pbcopy"
alias v=vim

# Pet aliases
alias p="pet --config $HOME/.dotfiles/pet/config.toml"
alias pse="pet --config $HOME/.dotfiles/pet/config.toml search | pbcopy"
alias pex="pet --config $HOME/.dotfiles/pet/config.toml exec"
alias pedit="pet --config $HOME/.dotfiles/pet/config.toml edit"


alias n="lima nerdctl"
alias nerdctl="lima nerdctl"

alias d=dig
alias wkpo="watch kubectl get pods"
alias kpo="kubectl get pods"
alias wkl="kubectl logs --follow"
alias kgn="kubectl get nodes"
alias wkgn="kubectl get nodes"
alias al="aws sso login"
alias ksn="kubectl config set-context --current --namespace"

alias o='code $(fzf)'
alias cpcommand="fc -ln -1 | pbcopy"

# kube() {
#   kubectl config use-context $(kubectl config get-contexts -o name | fzf)
#   kubectl config set-context --current --namespace="${1:-default}"
#   #PS1='${PWD##*/} [$(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ '
#   PS1='${PWD##*/} [$(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ '
# }

kube() {
  SELECTED_CONFIG_FILE=$(ls -p $HOME/.kube | grep -v / | fzf --border=top --border-label="| Select $HOME/.kube configuration file |")
  export KUBECONFIG="$HOME/.kube/${SELECTED_CONFIG_FILE}"

  SELECTED_CONTEXT=$(kubectl config get-contexts -o name | fzf --border=top --border-label="| Select K8S Context |")
  kubectl config use-context "${SELECTED_CONTEXT}"

  SELECTED_NAMESPACE=$(kubectl get namespaces | cut -d ' ' -f1 | fzf --border=top --border-label="| Select K8S Namespace |")

  kubectl config set-context --current --namespace="${SELECTED_NAMESPACE:-default}"

  PS1='[\033[01;32m\]\n\n${PWD##*/} [$(echo ${KUBECONFIG##*/}) - $(kubectl config current-context) - $(kubectl config view --minify -o jsonpath='{..namespace}')] $ \[\033[0m\]'
}

#kn() {
#  kubectl config set-context --current --namespace=$(kubectl get namespaces | cut -d ' ' -f1 | fzf)
#}

alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

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

if [ -e ~/.bashrc.local ]
then
  source ~/.bashrc.local
fi

code() {
   open -a Visual\ Studio\ Code.app $1
}

i() {
  echo "pwd: $PWD"
  date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"
  echo "Internal IPs:"
  ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
  echo "Public IP: $(curl -s ipinfo.io | jq -r .ip)"

}

function enc { openssl bf < $1 > $1.bf ;}

function enc-date { openssl bf < $1 > $(date +"%Y-%m-%d-%H-%M")-$1.bf ;}

export PATH=/usr/local/bin:$PATH
export PATH=~/.dotfiles/tasks:$PATH
export PATH=~/go/bin:$PATH