# Defined in - @ line 1
function s
    # cat ~/.ssh/config | grep 'Host ' | sed -e 's/Host /ssh /' | fzf $argv | xclip -selection clipboard
    set options (cat ~/.ssh/config | grep 'Host ' | sed -e 's/Host /ssh /' | fzf) 
    
    echo $options
    eval $options
end
