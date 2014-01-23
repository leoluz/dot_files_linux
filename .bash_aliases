create_gnome_launcher() {
        sudo gnome-desktop-item-edit /usr/share/applications/$1.desktop --create-new 
}
hg_cool_status() {
        hg log --template "{rev}:{date|isodate}|{branch}|{author}|{desc}\n{file_adds % '\t+ {file}\n'}{file_dels % '\t- {file}\n'}{file_mods % '\tM {file}\n'}  \n" $1
}
intellij() {
        nohup /bin/sh /opt/intellij/bin/idea.sh &
}

# User specific aliases and functions
alias idea="/home/leoluz/dev/ide/intellij/bin/idea.sh"
alias tomcatd="/opt/tomcat/bin/catalina.sh jpda start"
alias tomcats="/opt/tomcat/bin/catalina.sh jpda start"
alias tomcatp="/opt/tomcat/bin/catalina.sh stop"
alias launcher=create_gnome_launcher
alias hgstatus=hg_cool_status
