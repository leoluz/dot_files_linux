# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export JAVA_HOME="/opt/jdk/"
export JRE_HOME=$JAVA_HOME/jre
export ANT_HOME="/opt/ant"
export M2_HOME="/opt/mvn"

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$ANT_HOME/bin:$M2_HOME/bin
