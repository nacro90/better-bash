RED="\[\e[0;31m\]"
GRAY="\[\e[0;37m\]"
DARKGRAY="\[\e[0;90m\]"
YELLOW_BOLD="\[\e[1;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
GREEN="\[\e[0;32m\]"
GREEN_BOLD="\[\e[1;32m\]"
WHITE="\[\e[0;37m\]"
WHITE_BOLD="\[\e[1;37m\]"
BLOODRED="\[\e[1;31m\]"
CYAN="\[\e[1;34m\]"
LIGHT_CYAN="\[\e[1;96m\]"
LIGHT_GREEN="\[\e[1;32m\]"
TXTRST="\[\e[0m\]"

DELIMETER=' '
PROMPT='›'
CONTINUED='↪︎'
EMPTYSET='∅'
FAILMARK='!'
BULLET='•'

function parse_git_in_rebase {
    if [[ -d .git/rebase-apply ]]; then
        echo " REBASING"
    fi
}

function parse_git_dirty {
    git_output=$(git status | tail -1 | cut -d " " -f-3 | cut -d "," -f1)
    if [[ $git_output != "nothing to commit" ]]; then
        echo " $BULLET"
    fi
}

function parse_git_branch {
    branch=$(git status | head -1 | cut -d " " -f3-)
    if [[ -n $branch ]]; then
        echo $branch$BLOODRED"$(parse_git_dirty)"$(parse_git_in_rebase)
    fi
}

function git_module {
    if [[ $(git status 2> /dev/null) ]];then
        echo $DARKGRAY"$DELIMETER"[$GREEN$(parse_git_branch)$DARKGRAY];
    fi
 }

function emptiness_module {
    endpcount=$(ls -A1F | wc -l)
    if [[ 0 -eq ${endpcount} ]]; then
        echo $TXTRST"$DELIMETER"$YELLOW_BOLD$EMPTYSET
    fi
}

function venv_module {
    if [[ -n ${VIRTUAL_ENV} ]]; then
        echo $WHITE"$DELIMETER"\($WHITE_BOLD$(basename "$VIRTUAL_ENV")$WHITE\)
    fi
}

function end_module {
    echo "\n $WHITE$PROMPT $TXTRST"
}

function retval_module {
    if [ $exitcode != 0 ] && [ $exitcode != 148 ]; then
        echo "$DELIMETER$BLOODRED$FAILMARK"
    fi
}

function location_module {
    echo $TXTRST"$DELIMETER"$LIGHT_CYAN'\w'
}

function jobs_module {
    jcount=$(jobs | wc -l)
    if [[ 1 -lt $jcount ]]; then
        echo $TXTRST"$DELIMETER"$BLOODRED"\j jobs"
    elif [[ 1 -eq $jcount ]]; then
        echo $TXTRST"$DELIMETER"$BLOODRED"\j job"
    fi
}

function time_module {
    echo $DARKGRAY"$DELIMETER"'\A'
}

function set_bash_prompt {
    exitcode="$?"
    PS1='\n'$(retval_module)$(venv_module)$(jobs_module)$(location_module)
    PS1+=$(emptiness_module)$(git_module)$(time_module)$(end_module)
    PS2="$WHITE$CONTINUED  $TXTRST"
}

PROMPT_COMMAND=set_bash_prompt

