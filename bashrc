# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1="[\[\e[0;34m\]\D{%F %T}\[\e[0;37m\]] \[\e[0;33m\]\u\[\e[0m\]@\[\e[0;33m\]\h\[\e[m\]\[\e[0m\]:\[\e[0;33m\]\[\e[1;35m\]\w\[\e[m\] \[\e[0;39m\]\n\$ "

source ~/.bash/aliases
source ~/.bash/functions
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.bash/git_2line_prompt


