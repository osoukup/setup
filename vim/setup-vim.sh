#!/bin/bash
# script to setup VIM with plugins

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

while getopts ":d:hs" opt; do
    case ${opt} in
        d)
            DIR="$OPTARG"
            ;;
        h)
            echo "$0 [-d dir][-h][-s]"
            echo "   -d   set source directory"
            echo "   -h   print help"
            echo "   -s   setup only (no install)"
            exit 0
            ;;
        s)
            setup_only=true
            ;;
        \?)
            echo "invalid option -$OPTARG" 1>&2
            exit 1
            ;;
        :)
            echo "missing argument of option -$OPTARG" 1>&2
            exit 1
            ;;
    esac
done

if [[ -z "$setup_only" ]]; then
    sudo yum install git -y
    sudo yum install vim -y
fi

rm -f ~/.vimrc
ln -s "$DIR"/vimrc ~/.vimrc

rm -rf ~/.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

while read -r repo; do
    git clone --recursive "$repo" ~/.vim/bundle/"$( basename "$repo" | cut -d. -f1 )"
done < "$DIR"/setup-vim.conf
