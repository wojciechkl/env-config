#!/bin/sh

cp ~/.vimrc ./.vimrc
cp ~/.tmux.conf ./.tmux.conf
cp ~/.zshrc ./.zshrc
cp ~/.bashrc ./.bashrc
cp ~/.bash_profile ./.bash_profile
cp ~/.vim/colors/badwolf.vim ./colors/badwolf.vim
git add .
git commit -m "Config sync"
git push -u origin master
