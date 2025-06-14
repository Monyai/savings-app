#!/bin/bash

# 🤖 SavingsGoalアプリ開発組織 - 自動応答システム設定

SESSION="savings-app-dev"

echo "🤖 SavingsGoalアプリ開発組織 - 自動応答システム開始..."
echo "=================================================="

# 自動応答ルール設定関数
setup_auto_response() {
    local target="$1"
    local agent_name="$2"
    local role="$3"
    
    echo "🔧 $role 自動応答システム設定中..."
    
    local setup_message="
【🤖 自動応答システム設定】

あなたは SavingsGoalアプリ開発組織の $role として、以下の自動応答ルールで動作してください：

## 自動応答ルール
1. **指示受信時** → 即座確認応答 → 作業開始
2. **作業進捗** → 定期自動報告（1時間毎）
3. **完了時** → 成果物詳細報告
4. **問題発生** → 即座エスカレーション

## 自動報告フォーマット
\`\`\`bash
./agent-send.sh [報告先] '[$role] [報告種別]: [詳細内容]'
\`\`\`

## 指示書参照
- あなたの詳細な役割: instructions/${agent_name}.md
- 通信プロトコル、品質基準を必ず確認

## 今後の動作
- 全ての応答・報告を上記フォーマットで自動送信
- 人間の介入を最小化
- 効率的なマルチエージェント連携実現
- SavingsGoalアプリ開発の品質・スピード向上

自動応答システム設定完了と応答してください。
"
    
    # tmux経由で設定送信
    tmux send-keys -t "$target" "$setup_message" C-m
    sleep 1
    
    echo "✅ $role 自動応答システム設定完了"
}

# セッション存在確認
if ! tmux has-session -t $SESSION 2>/dev/null; then
    echo "❌ エラー: セッション '$SESSION' が見つかりません"
    echo "🚀 先にセットアップを実行してください: ./setup.sh"
    exit 1
fi

echo "📋 全エージェントに自動応答システム設定を適用中..."
echo ""

# 全エージェントに設定適用
setup_auto_response "$SESSION:president" "president" "PRESIDENT"
sleep 2

setup_auto_response "$SESSION:multiagent.0" "boss" "boss1 (UI_BOSS)"
sleep 2

setup_auto_response "$SESSION:multiagent.1" "worker" "worker1 (FIGMA)"
sleep 2

setup_auto_response "$SESSION:multiagent.2" "worker" "worker2 (FLUTTER1)"
sleep 2

setup_auto_response "$SESSION:multiagent.3" "worker" "worker3 (DB)"
sleep 2

echo ""
echo "🎉 全エージェント自動応答システム設定完了！"
echo ""
echo "📋 次のステップ:"
echo "  1. 🚀 開発開始指示:"
echo "     ./agent-send.sh president '【SavingsGoalアプリ開発開始指示】プロジェクト開始してください'"
echo ""
echo "  2. 📊 システム監視:"
echo "     tail -f logs/send_log.txt"
echo ""
echo "  3. 🔍 状態確認:"
echo "     ./agent-send.sh --status"
