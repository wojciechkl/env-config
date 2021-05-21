#!/bin/bash
# lets assume that we are inside tnmux session already
# 0 - backend
# 1 - terminal
# 2 - admin
# 3 - frontend
tmux send-keys 'printf "\033]2;%s\033\\" "backend";'
tmux send-keys C-m
tmux split-window -h
tmux send-keys 'printf "\033]2;%s\033\\" "admin";'
tmux send-keys C-m
tmux split-window -v
tmux send-keys 'printf "\033]2;%s\033\\" "frontend";'
tmux send-keys C-m
tmux select-pane -t 0
tmux split-window -v
tmux send-keys 'printf "\033]2;%s\033\\" "terminal";'
tmux send-keys C-m

tmux select-pane -t 0
tmux send-keys 'z backend' C-m
tmux send-keys 'npm start' C-m
tmux select-pane -t 2
tmux send-keys 'z admin' C-m
tmux send-keys 'npm start' C-m
tmux select-pane -t 3
tmux send-keys 'z frontend' C-m
tmux send-keys 'npm start' C-m
tmux select-pane 1
