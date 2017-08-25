#!/bin/sh

cp ~/.vimrc ~/Development/env-config/.vimrc
cp ~/.tmux.conf ~/Development/env-config/.tmux.conf
cp ~/.zshrc ~/Development/env-config/.zshrc
cp ~/.bashrc ~/Development/env-config/.bashrc
cp ~/.bash_profile ~/Development/env-config/.bash_profile
cp ~/.vim/colors/badwolf.vim ~/Development/env-config/colors/badwolf.vim
cd ~/Development/env-config
git add .
git commit -m "Config sync"
git push -u origin master
