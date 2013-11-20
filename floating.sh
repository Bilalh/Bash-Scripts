if [[ -n "$IS_FLOATING_ITERM" && "$IS_FLOATING_ITERM" = 'true'  ]]; then

alias stree='a stree'
alias mate='a mate'


function a(){
    "$@"
    toogle_item_floating.applescript
}

fi