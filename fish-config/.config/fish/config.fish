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
alias c='code .'
alias i='sudo apt install'


begin
    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

fish_add_path $HOME/.arkade/bin/
