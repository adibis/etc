#!/bin/bash
tmux new-session -d -s adibis

tmux new-window -t adibis:1 -n 'local'
tmux new-window -t adibis:2 -n 'htop'   'htop'
tmux new-window -t adibis:3 -n 'finch'  'finch'
tmux new-window -t adibis:4 -n 'vim'    'vim'

tmux select-window -t adibis:1
tmux attach-session -t adibis
