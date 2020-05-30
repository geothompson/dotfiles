  
     #Colors
tred='\033[0;31m' # Red
export txtblk='\e[0;30m' # Black - Regular
export txtred='\e[0;31m' # Red
export txtgrn='\e[0;32m' # Green
export txtylw='\e[0;33m' # Yellow
export txtblu='\e[0;34m' # Blue
export txtpur='\e[0;35m' # Purple
export txtcyn='\e[0;36m' # Cyan
export txtwht='\e[0;37m' # White
 
export bldblk='\e[1;30m' # Black - Bold
export bldred='\e[1;31m' # Red
export bldgrn='\e[1;32m' # Green
export bldylw='\e[1;33m' # Yellow
export bldblu='\e[1;34m' # Blue
export bldpur='\e[1;35m' # Purple
export bldcyn='\e[1;36m' # Cyan
export bldwht='\e[1;37m' # White
 
export undblk='\e[4;30m' # Black - Underline
export undred='\e[4;31m' # Red
export undgrn='\e[4;32m' # Green
export undylw='\e[4;33m' # Yellow
export undblu='\e[4;34m' # Blue
export undpur='\e[4;35m' # Purple
export undcyn='\e[4;36m' # Cyan
export undwht='\e[4;37m' # White
 
export bakblk='\e[40m'   # Black - Background
export bakred='\e[41m'   # Red
export bakgrn='\e[42m'   # Green
export bakylw='\e[43m'   # Yellow
export bakblu='\e[44m'   # Blue
export bakpur='\e[45m'   # Purple
export bakcyn='\e[46m'   # Cyan
export bakwht='\e[47m'   # White
 
export txtrst='\e[0m'    # Text Reset


# turn vim mode on 
set -o vi


set -o noclobber
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob

export PATH=/usr/bin/lynx:$PATH
export PATH=$HOME/repos/gitlab.com/snapplesacue/dotfiles/scripts/:$PATH
export PATH=$HOME/repos/gitlab.com/snapplesacue/README/scripts/:$PATH
export PATH=$HOME/scripts:$PATH
export PATH="$DENO_INSTALL/bin:$PATH"
export DENO_INSTALL="/home/geo_thom/.deno"


d() {
lynx -cfg ~/scripts/lynx/lynx.cfg -lss ~/scripts/lynx/lynx.lss "duckduckgo.com/lite?q=$*"
}
export -f d



fmt_time () { #format time just the way I likes it
    if [ `date +%p` = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi
    date +"%l:%M:%S$meridiem"|sed 's/ //g'
}

pwdtail () { #returns the last 2 fields of the working directory
    pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

chkload () { #gets the current 1m avg CPU load
    local CURRLOAD=`uptime|awk '{print $8}'`
    if [ "$CURRLOAD" > "1" ]; then
        local OUTP="HIGH"
    elif [ "$CURRLOAD" < "1" ]; then
        local OUTP="NORMAL"
    else
        local OUTP="UNKNOWN"
    fi
    echo $CURRLOAD
}

if [ -f $HOME/.bash_aliases ]
then
  . $HOME/.bash_aliases
fi


LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

prompt_command() {
    if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
        ERRPROMPT=" "
    else
        ERRPROMPT='->($?) '
    fi
    if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
        BRANCH="\$(__git_ps1 '[ %s ] ')"
    fi
    local TIME=`fmt_time` # format time for prompt string
    local LOAD=`uptime|awk '{min=NF-2;print $min}'`
    local GREEN="\[\033[0;32m\]"
    local CYAN="\[\033[0;36m\]"
    local BCYAN="\[\033[1;36m\]"
    local BLUE="\[\033[0;34m\]"
    local GRAY="\[\033[0;37m\]"
    local DKGRAY="\[\033[1;30m\]"
    local WHITE="\[\033[1;37m\]"
    local RED="\[\033[0;31m\]"
    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"
    # set the titlebar to the last 2 fields of pwd
    local TITLEBAR='\[\e]2;`pwdtail`\a'
    export PS1="\[${TITLEBAR}\]${CYAN}[ ${BCYAN}\u${GREEN}@${BCYAN}\
\h${DKGRAY}(${LOAD}) ${WHITE}${TIME} ${CYAN}]${RED}$ERRPROMPT${GRAY}\
\w\n${GREEN}${BRANCH}${DEFAULT}$ "
}
PROMPT_COMMAND=prompt_command
