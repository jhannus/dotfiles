# .bash_profile

export CLICOLOR=1
#export LS_OPTIONS='--color=auto'
export LSCOLORS=cxfxafdxbxegedabagacad

# system/all configurations...
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


# User specific environment and startup
# export MAVEN_OPTS="-Xmx1024m -Xms256m -XX:MaxPermSize=256m"
export EDITOR="emacs -nw"
export SERVICES_ENV=local
export PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;33m\]\h\[\e[m\]\[\e[0m\]:\[\e[0;33m\]\[\e[1;35m\]\W\[\e[m\] \[\e[0;33m\]\$\[\e[m\] \[\e[0;37m\]'
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
export PATH=$HOME/bin:$HOME/dse/bin:$PATH

eval "$(rbenv init -)"

# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -e $(brew --prefix nvm)/nvm.sh ]; then
   export NVM_DIR="$HOME/.nvm"
   source $(brew --prefix nvm)/nvm.sh
fi

# environment/machine specific configurations...
if [ -f ~/.bash_env ]; then
  . ~/.bash_env
fi