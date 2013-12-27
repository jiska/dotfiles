# cd
alias u='cd ..'
alias cdw='cd ~/Workspace'
alias cdv='cd ~/Vagrant'

# ls
alias ls='ls -FG'
alias l1='ls -1'
alias ll='ls -lFhG'
alias la='ls -AFhG'
alias lla='ls -lFAhG'
alias l='ls -CFG'

# mv, mv, cp
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# du, df
alias du='du -hs'
alias df='df -h'

# find
alias find='gfind'

# free
alias free='free -m'

# grep
alias grep='grep -i'

# svn
alias svndf='svn diff | less'
alias svnqd='svn status | grep "? " | awk "{print($2)}" | xargs rm'

# readlink
alias readlink='greadlink'

# nkf
alias nkfswo='nkf -s -x -Lw --overwrite'

# git
alias oppai='git'

# top
alias top='htop'

# tar
alias tar='gnutar'

# rspec
alias rspec='rspec -c'
