RED="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
DARKGRAY="\[\e[0;90m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
GREEN="\[\e[0;32m\]"
WHITE="\[\e[0;37m\]"
WHITE_BOLD="\[\e[1;37m\]"
BLOODRED="\[\e[1;31m\]"
CYAN="\[\e[1;34m\]"
LIGHT_CYAN="\[\e[1;96m\]"
LIGHT_GREEN="\[\e[1;32m\]"
TXTRST="\[\e[0m\]"

DOWNBAR='\342\224\214'
HORBAR='\342\224\200'
UPBAR='\342\224\224'
HORBARPLUG='$'
# HORBARPLUG='\342\225\274'
CROSS='\342\234\227'

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_in_rebase {
    [[ -d .git/rebase-apply ]] && echo " REBASING"
}

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
    branch=$(git branch 2> /dev/null | grep "*" | sed -e s/^..//g)
    if [[ -z ${branch} ]]; then
        return
    fi
    echo ${branch}$(parse_git_dirty)$(parse_git_in_rebase)
}

function git_module {
    if [[ $(git status 2> /dev/null) ]];then
        echo $WHITE$HORBAR[$WHITE_BOLD$(parse_git_branch)$WHITE];
    fi
 }

function file_module {
    dircount=$(ls -A1F | grep "\/$" | wc -l)
    filecount=$(ls -A1F | grep "\/$" -v | wc -l)

    if [ 0 -lt ${dircount} ] && [ 0 -lt ${filecount} ]; then
        echo $HORBAR[$YELLOW$dircount"d"$WHITE\|$YELLOW$filecount"f"$WHITE]
    fi

    if [ 0 -lt ${dircount} ] && [ 0 -eq ${filecount} ]; then
        echo $HORBAR[$YELLOW$dircount"d"$WHITE]
    fi

    if [ 0 -eq ${dircount} ] && [ 0 -lt ${filecount} ]; then
        echo $HORBAR[$YELLOW$filecount"f"$WHITE]
    fi

    if [ 0 -eq ${dircount} ] && [ 0 -eq ${filecount} ]; then
        echo $HORBAR[$YELLOW"empty"$WHITE]
    fi
    # echo $HORBAR[$BLUE$(ls | wc -l) files, $(ls -lah | grep -m 1 total | sed 's/total //')$WHITE]
}

function venv_module {
    if [[ -n ${VIRTUAL_ENV} ]]; then
        echo $HORBAR[$WHITE_BOLD$(basename "$VIRTUAL_ENV")$WHITE]
    fi
}

function end_module {
    echo "\n"$WHITE$UPBAR$HORBAR$HORBARPLUG $TXTRST
}

function begin_module {
    echo $WHITE$DOWNBAR
}

function retval_module {
    [[ $? != 0 ]] && echo [$BLOODRED$CROSS$WHITE]
}

function user_module {
     echo $HORBAR[$(if [[ ${EUID} == 0 ]]; then echo $BLOODRED'\h'; else echo $YELLOW'\u'$GRAY'@'$LIGHT_CYAN'\h'; fi)$WHITE]
}

function location_module {
    echo $HORBAR[$LIGHT_CYAN'\w'$WHITE]
}

function jobs_module {
    jcount=$(jobs | wc -l)
    if [[ 1 -lt ${jcount} ]]; then
        echo $HORBAR[$BLOODRED"\j jobs"$WHITE]
    elif [[ 1 -eq ${jcount} ]]; then
        echo $HORBAR[$BLOODRED"\j job"$WHITE]
    fi
}

function time_module {
    echo $DARKGRAY$HORBAR['\A']$WHITE
}

function set_bash_prompt {
    PS1=$(begin_module)$(retval_module)$(venv_module)$(jobs_module)$(location_module)$(file_module)$(git_module)$(time_module)$(end_module)
}

PROMPT_COMMAND=set_bash_prompt

