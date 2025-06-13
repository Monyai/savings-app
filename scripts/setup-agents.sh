#!/bin/bash

# tmux セッション名
SESSION="savings-app-dev"

# 既存セッションがあれば削除
tmux kill-session -t $SESSION 2>/dev/null

# 新規セッション作成
tmux new-session -d -s $SESSION

# 5つのペインに分割
tmux split-window -h -t $SESSION:0
tmux split-window -v -t $SESSION:0.0
tmux split-window -v -t $SESSION:0.1
tmux split-window -v -t $SESSION:0.2

# 各ペインに役割を設定
tmux send-keys -t $SESSION:0.0 "echo '🏢 PRESIDENT - 統括管理'" C-m
tmux send-keys -t $SESSION:0.1 "echo '👨‍💻 BOSS_UI - UI統括'" C-m  
tmux send-keys -t $SESSION:0.2 "echo '👨‍💻 BOSS_BACKEND - バックエンド統括'" C-m
tmux send-keys -t $SESSION:0.3 "echo '👷 WORKER_FLUTTER1 - UI実装'" C-m
tmux send-keys -t $SESSION:0.4 "echo '👷 WORKER_FLUTTER2 - ロジック実装'" C-m

echo "tmux session '$SESSION' created successfully!"
echo "Attach with: tmux attach-session -t $SESSION"
