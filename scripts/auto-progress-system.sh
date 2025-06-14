#!/bin/bash

SESSION="savings-app-dev"

# 自動進捗監視・報告システム
start_auto_monitoring() {
    echo "📊 自動進捗監視システム開始..."
    
    while true; do
        # 30分毎に自動進捗チェック
        sleep 1800  # 30分
        
        # PRESIDENT による自動進捗確認
        tmux send-keys -t $SESSION:0.0 "
        claude << 'AUTO_PROGRESS_CHECK'
        【自動進捗チェック】PRESIDENT として定期進捗確認実行：
        
        ## 各BOSS進捗要求
        tmux send-keys -t $SESSION:0.1 '[PRESIDENT] 30分定期進捗報告要求' C-m
        tmux send-keys -t $SESSION:0.2 '[PRESIDENT] 30分定期進捗報告要求' C-m
        
        ## 問題検出・自動対応
        進捗遅延・問題検出時は自動でリソース調整・優先度変更を実行
        
        ## Slack自動報告
        進捗状況をSlack #savings-app-dev に自動送信
        
        実行してください。
AUTO_PROGRESS_CHECK
        " C-m
        
    done &
}

# バックグラウンドで自動監視開始
start_auto_monitoring
echo "✅ 自動進捗監視システム稼働中..."
