
# export PS1="${GREEN}[\u]${NORMAL}:${BLUE}[\w]${NORMAL}$ "
# source <(kubectl completion bash)

alias t='terraform'
alias k=kubectl
alias kubectx='kubectl ctx'
alias kctx='kubectl ctx'
alias kubens='kubectl ns'
alias kns='kubectl ns'

# complete -F __start_kubectl k

# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kube_prompt() {
    __kube_ps1()
    {
        # Get current context
        CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")
	    NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}')


        if [ -n "$CONTEXT" ]; then
            echo "${CONTEXT}:${NAMESPACE}"
        fi
    }

    export PS1="${GREEN}[\u]${YELLOW}[\$(__kube_ps1)]${NORMAL}:${BLUE}\w${NORMAL} \$ "
}

# export PATH=$PATH:$HOME/.arkade/bin/




# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias open='xdg-open'

alias tp='terraform plan -out=plan.out'

alias tv='terraform show -json plan.out > plan.json  && terraform-visual --plan plan.json && xdg-open terraform-visual-report/index.html'
alias tpv='terraform plan -out=plan.out && terraform show -json plan.out > plan.json  && terraform-visual --plan plan.json && xdg-open terraform-visual-report/index.html'
alias tap='terraform apply plan.out'
alias c='code .'

# export PATH=/usr/local/kafka/bin:$PATH


x(){
    if [ -f $1 ] ; then
            case $1 in
                    *.tar.bz2)   tar xvjf $1    ;;
                    *.tar.gz)    tar xvzf $1    ;;
                    *.bz2)       bunzip2 $1     ;;
                    *.rar)       unrar x $1     ;;
                    *.gz)        gunzip $1      ;;
                    *.tar)       tar xvf $1     ;;
                    *.tbz2)      tar xvjf $1    ;;
                    *.tgz)       tar xvzf $1    ;;
                    *.zip)       unzip $1       ;;
                    *.Z)         uncompress $1  ;;
                    *.7z)        7z x $1        ;;
                    *)           echo "Unable to extract '$1'" ;;
            esac
    else
            echo "'$1' is not a valid file"
    fi
}
