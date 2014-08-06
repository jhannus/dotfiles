# .bash_profile

export CLICOLOR=1
#export LS_OPTIONS='--color=auto'
export LSCOLORS=cxfxafdxbxegedabagacad

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

# Setting PATH for JRuby 1.6.6
# The orginal version is saved in .bash_profile.jrubysave
#PATH="${PATH}:/Library/Frameworks/JRuby.framework/Versions/Current/bin"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="/Users/jhannus/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;33m\]\h\[\e[m\]\[\e[0m\]:\[\e[0;33m\]\[\e[1;35m\]\W\[\e[m\] \[\e[0;33m\]\$\[\e[m\] \[\e[0;37m\]'

source /opt/boxen/env.sh

export CC=$(brew --prefix)/Cellar/apple-gcc42/4.2.1-5666.3/bin/gcc-4.2
export CXX=$(brew --prefix)/Cellar/apple-gcc42/4.2.1-5666.3/bin/g++-4.2
export CPP=$(brew --prefix)/Cellar/apple-gcc42/4.2.1-5666.3/bin/cpp-4.2
