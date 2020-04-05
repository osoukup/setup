#!/bin/bash
# script to setup VIM with plugins

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ $1 != "-s" ]]; then
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
