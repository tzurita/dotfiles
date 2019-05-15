#
# .bash_profile
#
#

# Nicer prompt.
export PS1="\[\e[0;32]\u@\[\e[1;32m\]\h \[\e[0;2m\]\w \[\e[0m\]\$ "
# export PS1="\[\e[0;32m\] \[\e[1;32m\]\t \[\e[0;2m\]\w \[\e[0m\]\$ "

# Use colors.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Custom $PATH with extra locations.
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:/usr/local/git/bin:$PATH

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.bash_aliases ]
then
    source ~/.bash_aliases
fi

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.aliases ]
then
    source ~/.aliases
fi

# Include bashrc file (if present).
if [ -f ~/.bashrc ]
then
    source ~/.bashrc
fi

if [ "$OS" = "Linux" -a -f /etc/bash_completion ]
then
    source /etc/bash_completion
fi


# Git aliases.
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Git upstream branch syncer.
# Usage: gsync master (checks out master, pull upstream, push origin).
function gsync() {
if [[ ! "$1" ]] ; then
    echo "You must supply a branch."
    return 0
fi

BRANCHES=$(git branch --list $1)
if [ ! "$BRANCHES" ] ; then
    echo "Branch $1 does not exist."
    return 0
fi

git checkout "$1" && \
git pull upstream "$1" && \
git push origin "$1"
}


# Use nvm.
# export NVM_DIR="$HOME/.nvm"
# . "$brew_prefix/opt/nvm/nvm.sh"

# Use rbenv.
# if [ -f /usr/local/bin/rbenv ]; then
#   eval "$(rbenv init -)"
# fi

# Python settings.
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages"

# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora27|debian9|debian8|ubuntu1404|etc.]
dockrun() {
docker run -it geerlingguy/docker-"${1:-ubuntu1604}"-ansible /bin/bash
}

# Enter a running Docker container.
function denter() {
    if [[ ! "$1" ]] ; then
        echo "You must supply a container ID or name."
        return 0
    fi

    docker exec -it $1 bash
    return 0
}

# Docker image visualization (usage: `dockviz images -t`).
alias dockviz="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"

# Delete a given line number in the known_hosts file.
knownrm() {
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]] ; then
        echo "error: line number missing" >&2;
    else
        sed -i '' "$1d" ~/.ssh/known_hosts
    fi
}

# Ask for confirmation when 'prod' is in a command string.
prod_command_trap () {
    if [[ $BASH_COMMAND == *prod* ]]
    then
        read -p "Are you sure you want to run this command on prod [Y/n]? " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo -e "\nRunning command \"$BASH_COMMAND\" \n"
        else
            echo -e "\nCommand was not run.\n"
            return 1
        fi
    fi
}
# shopt -s extdebug
# trap prod_command_trap DEBUG

function blt() {
    if [[ ! -z ${AH_SITE_ENVIRONMENT} ]]; then
        PROJECT_ROOT="/var/www/html/${AH_SITE_GROUP}.${AH_SITE_ENVIRONMENT}"
    elif [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
        PROJECT_ROOT=$(git rev-parse --show-cdup)
    else
        PROJECT_ROOT="."
    fi

    if [ -f "$PROJECT_ROOT/vendor/bin/blt" ]; then
        $PROJECT_ROOT/vendor/bin/blt "$@"

    # Check for local BLT.
    elif [ -f "./vendor/bin/blt" ]; then
        ./vendor/bin/blt "$@"

    else
        echo "You must run this command from within a BLT-generated project."
        return 1
    fi
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


