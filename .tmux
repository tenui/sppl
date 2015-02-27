#!/usr/bin/env sh
SESSION="$1"
tmux new-session -s "$SESSION" -n vim -d
tmux send-keys "$EDITOR" C-m
tmux new-window -n shell -t "$SESSION"
tmux new-window -n server -t "$SESSION"
tmux send-keys "bundle exec foreman start" C-m
tmux new-window -n logs -t "$SESSION"
tmux send-keys "tail -f logs/development.log" C-m
tmux new-window -n tests -t "$SESSION"
tmux send-keys "watchr test/watchr.rb" C-m
tmux select-window -t "$SESSION":0

