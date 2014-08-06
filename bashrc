# .bashrc
source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.bash/git_prompt

#osascript -e "set Volume 100" -e 'say "Repent for your sins for Jesus is coming!"'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias emacs='emacs -nw'
alias mountjhannus='sudo mount -t cifs -o username=jhannus //c1-filer03/jhannus /mnt/jhannus-c1-filer03/'
alias editprofile='emacs ~/.bashrc'
alias ls='ls -G'
alias ll='ls -l'
alias gitlog='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

# User specific aliases and functions

#export MAVEN_OPTS="-Xmx1024m -Xms256m -XX:MaxPermSize=256m"
#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
#export PATH=/sbin:/usr/local/subversion/bin:$JAVA_HOME/bin:$PATH:~/src/scripts::/usr/local/mysql/bin

export EDITOR="emacs -nw"
export SERVICES_ENV=local

# git completeion
#source `brew --prefix git`/etc/bash_completion.d/git-completion.bash
#source /usr/local/Cellar/git/1.7.11/etc/bash_completion.d/git-completion.bash

# Source global definitions
if [ -f ~/src/scripts/git_prompt ]; then
	. ~/src/scripts/git_prompt
fi

function svndeletemetadata() {
    find . -name ".svn" -exec rm -rf {} \;
}

function svngetmods() {
    svn status | grep "^$1" | awk '{print $2}'
}

function svnadd() {
    newfiles=$(svngetmods "?")

    if [ $(echo -n $newfiles) = "" ]; then
	echo "No new files to add."
    else
	echo $newfiles | xargs svn add
    fi
}

function svnrevert() {
    modtype="M"
    if [ -n "$1" ]; then modtype=$1; fi
    newfiles=$(svngetmods $modtype)

    if [ $(echo -n $newfiles) = "" ]; then
        echo "No modified files to revert."
    else
        echo $newfiles | xargs svn revert
    fi
}

function svnstatgrep() {
    grepfor="$1"
    if [ -z "$1" ]; then 
	echo "usage: svnstatgrep <grep-string>"
	return;
    fi
    newfiles=$(svngetmods "\(M\|A\)")

    if [ "$newfiles" = "" ]; then
        echo "No modified files to grep."
    else
        echo $newfiles | xargs grep -i $grepfor
    fi
}

function maven_debug_opt() {
    if [ -z "$1" ]; then
        echo "usage: maven_debug_opts [-s] <debug port>";
        return;
    fi
    port="$1";
    suspend="n";
    if [ "$1" == "-s" ]; then
	suspend="y";
    fi
    if [ "$suspend" == "y" -a -n "$2" ]; then
	port="$2";
    fi

    if [[ $port =~ ^-?[0-9]+$ ]]; then
	export MAVEN_OPTS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=$port,server=y,suspend=$suspend"
    else
	echo "usage: maven_debug_opts [-s] <debug port>";
        return;
    fi
    
    
}

#PATH=`brew --prefix emacs`/bin:$PATH

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;33m\]\h\[\e[m\]\[\e[0m\]:\[\e[0;33m\]\[\e[1;35m\]\W\[\e[m\] \[\e[0;33m\]\$\[\e[m\] \[\e[0;37m\]'
