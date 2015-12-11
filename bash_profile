_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != ${p//\/} ]]&&(($s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

if [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PS1='\[\e[0;32m\]$(_dir_chomp "$(pwd)" 20)\[\e[0;34m\]$(__git_ps1 " (%s)")\[\e[0m\] \$ '
export CLICOLOR=true

export EDITOR=/usr/local/bin/vim
export N_PREFIX=$HOME/n

export PATH=""
eval $(/usr/libexec/path_helper)
export PATH=$GOPATH/bin:$N_PREFIX/bin:~/bin:/usr/local/sbin:$PATH

eval "$(docker-machine env default)"
