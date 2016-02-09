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

export GOPATH=$HOME/gocode
export GO15VENDOREXPERIMENT=1

export PATH=""
eval $(/usr/libexec/path_helper)
export PATH=$GOPATH/bin:$N_PREFIX/bin:~/bin:/usr/local/sbin:$PATH

#export HOMEBREW_GITHUB_API_TOKEN=

DOCKER_ENV=""

docker_env() {
    if [ $# == 0 ]; then
        docker-machine ls
        return
    fi

    docker-machine start $1
    cmd=$(docker-machine env $1)
    eval $cmd
    DOCKER_ENV=$1
}

mk_docker_machine() {
    if [ $# != 2 ]; then
        echo "Usage: mk_docker_machine [name] [subnet]"
        return 1
    fi

    docker-machine create -d virtualbox \
        --virtualbox-memory 2048 \
        --virtualbox-cpu-count 2 \
        --virtualbox-host-dns-resolver \
        --virtualbox-hostonly-cidr "192.168.$2.1/24" \
        $1

    return $?
}

alias cd='cd -P'
