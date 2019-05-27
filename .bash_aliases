alias gcs='google-chrome-stable'
alias document-viewer='evince'
alias pass='date +%s | sha256sum | base64 | head -c 32 ; echo'
alias reload='source ~/.bashrc'
alias todo='vim ~/Documents/notes/todo.txt'
alias notes='cd ~/Documents/notes'

# Functions that can be treated like aliases

mdcat() { pandoc "$1" | lynx -stdin; }



