#!/bin/bash

SESSION="savings-app-dev"

echo "📊 マルチエージェント連携監視開始..."

# 各paneの状況リアルタイム監視
monitor_pane() {
    local pane=$1
    local role=$2
    echo "=== $role (pane $pane) ==="
    tmux capture-pane -t $SESSION:0.$pane -p | tail -10
    echo ""
}

# 10秒間隔で5回監視
for i in {1..5}; do
    echo "📊 監視ラウンド $i/5 ($(date '+%H:%M:%S'))"
    echo "----------------------------------------"
    
    monitor_pane 0 "PRESIDENT"
    monitor_pane 1 "BOSS_UI"  
    monitor_pane 2 "BOSS_BACKEND"
    monitor_pane 3 "WORKER_FIGMA"
    monitor_pane 4 "WORKER_FLUTTER1"
    
    echo "========================================"
    sleep 10
done

# 最終状況確認
echo "📋 最終状況確認"
claude << 'MONITOR_ANALYSIS'
監視ログを分析して、マルチエージェント連携の評価を行ってください：

分析項目：
1. 通信フロー効率性（指示→実行→報告サイクル）
2. エージェント間の協調度
3. 問題発生時の対応速度
4. 品質チェックの実効性
5. PRESIDENT統制力

Slack #savings-app-dev に監視分析結果を報告：
\"📊 【連携監視分析結果】
⏰ 監視期間: [開始]〜[終了]
📈 連携効率性: [評価]
🤝 協調動作: [評価]  
⚡ 問題対応: [評価]
🔍 品質保証: [評価]
👑 統制力: [評価]

💡 最適化提案: [具体的改善提案]\"

実行してください。
MONITOR_ANALYSIS

echo "✅ 連携監視完了"
