#!/bin/sh

cp ~/.vimrc /Users/wklicki/Development/env-config/.vimrc
cp ~/.tmux.conf /Users/wklicki/Development/env-config/.tmux.conf
cp ~/.zshrc /Users/wklicki/Development/env-config/.zshrc
cp ~/.bashrc /Users/wklicki/Development/env-config/.bashrc
cp ~/.bash_profile /Users/wklicki/Development/env-config/.bash_profile
cd /Users/wklicki/Development/env-config
git add .
git commit -m "Synchronizacha konfiguracji"
git push -u origin master
