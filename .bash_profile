# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
GIT_PS1_SHOWDIRTYSTATE=1

# User specific environment and startup programs
export JAVA_HOME="/opt/jdk/"
export JRE_HOME=$JAVA_HOME/jre
export ANT_HOME="/opt/ant"
export M2_HOME="/opt/mvn"

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$ANT_HOME/bin:$M2_HOME/bin
