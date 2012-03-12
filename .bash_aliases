# cd
alias ..='cd ..'
alias cdw='cd ~/Workspace'

# ls
alias ll='ls -lh'
alias la='ls -Ah'
alias l='ls -CF'

# mv, mv, cp
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# du, df
alias du='du -hs'
alias df='df -h'

# svn
alias svndf='svn diff | less'
alias svnqd='svn status | grep "? " | awk "{print($2)}" | xargs rm'

# spec
alias spec='spec -cfs'

# php*
alias pu='phpunit --verbose --colors'
alias pud='phpunit --verbose --colors --debug'
alias pb='php_beautifier -s2 -l "ArrayNested() NewLines(before=public:private:protected:if:switch:while:for:foreach:T_CLASS:T_COMMENT:break)"'
alias pr='phpunitrunner -a -c -n'


# symfony
alias symfony='./symfony'

# impressive
alias impressive='impressive --transition none'
