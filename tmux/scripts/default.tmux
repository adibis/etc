#!/bin/sh
#-----------------------------------------------------------------------------#
# filename: default.tmux
# purpose : setup the default tmux session I usually use
#-----------------------------------------------------------------------------#
# TODO: Better would be to use tmuxinator. It allows this scripting to be
# done in a YAML format. Much easier and cleaner.
#-----------------------------------------------------------------------------#

SESSION_NAME=$USER
cd $HOME

tmux has-session -t $SESSION_NAME
if [ $? -eq 0 ]; then
    echo "Session $SESSION_NAME already exists. Attaching."
    sleep 2
    tmux -2 attach -t $SESSION_NAME
    exit 0;
fi

tmux new-session -d -s $SESSION_NAME
tmux set-window-option -t $SESSION_NAME -g automatic-rename off

tmux new-window -t $SESSION_NAME:1 -n main
tmux split-window -h
tmux split-window -v
tmux new-window -t $SESSION_NAME:2 -n aux
tmux new-window -t $SESSION_NAME:3 -n weechat 'weechat-curses'
tmux new-window -t $SESSION_NAME:4 -n ncmpcpp 'ncmpcpp'

tmux select-window -t $SESSION_NAME:1
tmux attach -t $SESSION_NAME
