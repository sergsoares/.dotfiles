# Defined in - @ line 1
function h --wraps='history | fzf' --description 'alias h=history | fzf'
  history | fzf $argv | xclip -selection clipboard;
end
