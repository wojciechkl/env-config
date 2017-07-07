#!/bin/sh

cp ~/.vimrc /Users/wklicki/Development/env-config/.vimrc
cp ~/.tmux.conf /Users/wklicki/Development/env-config/.tmux.conf
cd /Users/wklicki/Development/env-config
git add .
git commit -S -m "Synchronizacha konfiguracji"
git push -u origin master
