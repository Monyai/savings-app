#!/bin/bash

# SavingsGoal 自動監視システム
# 30分毎の進捗チェックと品質管理

LOG_FILE="/tmp/savings-app-monitor.log"
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

# 進捗チェック関数
check_progress() {
    echo "[$(date)] 自動進捗チェック開始" >> "$LOG_FILE"
    
    # UI チーム進捗確認
    tmux send-keys -t savings-app-dev:0.1 '[MONITOR] UI進捗状況を報告してください' C-m
    
    # Backend チーム進捗確認
    tmux send-keys -t savings-app-dev:0.2 '[MONITOR] Backend進捗状況を報告してください' C-m
    
    # 品質チェック実行
    if [ -d "/Users/monyai/Project/dev/savings-app/src" ]; then
        cd /Users/monyai/Project/dev/savings-app/src
        
        # Flutter analyze
        if command -v flutter &> /dev/null; then
            flutter analyze >> "$LOG_FILE" 2>&1
        fi
        
        # Test実行
        if [ -d "test" ]; then
            flutter test >> "$LOG_FILE" 2>&1
        fi
    fi
    
    # Slack通知
    if [ -n "$SLACK_WEBHOOK" ]; then
        curl -X POST "$SLACK_WEBHOOK" \
            -H 'Content-Type: application/json' \
            -d "{\"text\":\"🤖 SavingsGoal 自動開発進捗 [$(date +%H:%M)]\\n進捗チェック実行完了\"}" \
            2>/dev/null
    fi
}

# メインループ
while true; do
    check_progress
    sleep 1800  # 30分待機
done