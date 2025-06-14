#!/bin/bash

# エージェント間自動通信システム
SESSION="savings-app-dev"

# 各エージェントに進捗報告を指示
send_progress_request() {
    local pane=$1
    local agent_name=$2
    
    tmux send-keys -t $SESSION:0.$pane "
echo '📊 [$agent_name] 進捗報告タイム'
claude << 'AGENT_PROMPT'
あなたは$agent_nameです。
以下の形式で現在の作業状況をSlackに報告してください:

**📋 [$agent_name] 作業報告**
🕐 報告時刻: $(date '+%Y-%m-%d %H:%M')
✅ 完了した作業:
- [具体的な成果物]
⚠️ 現在の課題:
- [問題とその対応状況]
📅 次の予定:
- [次回までの予定作業]
📊 全体進捗への影響:
- [プロジェクト全体への貢献度]

報告先: Slack #savings-app-dev
AGENT_PROMPT
" C-m
}

# 全エージェントに進捗報告指示
echo "🚀 全エージェントに進捗報告を指示..."
send_progress_request 0 "PRESIDENT"
send_progress_request 1 "BOSS_UI" 
send_progress_request 2 "BOSS_BACKEND"
send_progress_request 3 "WORKER_FLUTTER1"
send_progress_request 4 "WORKER_FLUTTER2"

echo "✅ 進捗報告指示完了"
