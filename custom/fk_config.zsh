. /home/fabian/zsh-addons/z.sh
function precmd () {
    _z --add "$(pwd -P)"
}
