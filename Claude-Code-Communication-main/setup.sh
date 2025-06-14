#!/bin/bash

# 🏢 SavingsGoalアプリ開発組織セットアップ
# 完全自動通信システム - savings-app統合版

set -e  # エラー時に停止

SESSION="savings-app-dev"

# 色付きログ関数
log_info() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[1;34m[SUCCESS]\033[0m $1"
}

log_warning() {
    echo -e "\033[1;33m[WARNING]\033[0m $1"
}

echo "🏢 SavingsGoalアプリ開発組織セットアップ開始..."
echo "=============================================="
echo ""

# STEP 1: 既存セッションクリーンアップ
log_info "🧹 既存セッションクリーンアップ開始..."

tmux kill-session -t $SESSION 2>/dev/null && log_info "既存セッション削除完了" || log_info "既存セッションは存在しませんでした"
tmux kill-session -t multiagent 2>/dev/null && log_info "旧multiagentセッション削除完了" || log_info "旧multiagentセッションは存在しませんでした"
tmux kill-session -t president 2>/dev/null && log_info "旧presidentセッション削除完了" || log_info "旧presidentセッションは存在しませんでした"

# ログディレクトリ・完了ファイルクリア
mkdir -p ./logs ./tmp
rm -f ./tmp/worker*_done.txt 2>/dev/null && log_info "既存の完了ファイルをクリア" || log_info "完了ファイルは存在しませんでした"
rm -f ./logs/send_log.txt 2>/dev/null && log_info "既存のログファイルをクリア" || log_info "ログファイルは存在しませんでした"

log_success "✅ クリーンアップ完了"
echo ""

# STEP 2: SavingsGoalアプリ開発組織セッション作成（5分割統合レイアウト）
log_info "📺 SavingsGoalアプリ開発組織セッション作成開始（5分割統合）..."

# メインセッション作成（全エージェント統合）
tmux new-session -d -s $SESSION -n "all-agents"

# 5分割レイアウト作成
# 最初に水平分割（上下）
tmux split-window -v -t $SESSION:all-agents

# 上部をさらに水平分割（PRESIDENT + boss1）
tmux split-window -h -t $SESSION:all-agents.0

# 下部を3分割（worker1, worker2, worker3）
tmux split-window -h -t $SESSION:all-agents.2
tmux split-window -h -t $SESSION:all-agents.3

# 各ペインの役割設定
PANE_ROLES=("PRESIDENT" "boss1 (UI_BOSS)" "worker1 (FIGMA)" "worker2 (FLUTTER1)" "worker3 (DB)")
PANE_COLORS=("\033[1;35m" "\033[1;31m" "\033[1;34m" "\033[1;36m" "\033[1;33m")
PANE_ICONS=("👑" "👨‍💻" "🎨" "📱" "💾")

log_info "各エージェントペイン設定中（5分割）..."
for i in {0..4}; do
    # 作業ディレクトリ設定
    tmux send-keys -t $SESSION:all-agents.$i "cd /Users/monyai/Project/dev/savings-app" C-m

    # カラープロンプト設定
    tmux send-keys -t $SESSION:all-agents.$i "export PS1='(${PANE_COLORS[$i]}${PANE_ROLES[$i]}\[\033[0m\]) \[\033[1;32m\]\w\[\033[0m\]\$ '" C-m

    # ウェルカムメッセージ
    tmux send-keys -t $SESSION:all-agents.$i "echo '${PANE_ICONS[$i]} ${PANE_ROLES[$i]} - SavingsGoalアプリ開発'" C-m
    tmux send-keys -t $SESSION:all-agents.$i "echo '========================================'" C-m
done

log_success "✅ 開発組織セッション作成完了"
echo ""

# STEP 3: Claude Code自動起動（危険回避オプション付き）
log_info "🤖 各エージェントでClaude Code自動起動中（5分割）..."

# 全エージェント起動
AGENT_NAMES=("PRESIDENT" "boss1" "worker1" "worker2" "worker3")
for i in {0..4}; do
    log_info "${AGENT_NAMES[$i]} Claude Code起動..."
    tmux send-keys -t $SESSION:all-agents.$i "claude --dangerously-skip-permissions" C-m
    sleep 2
done

log_success "✅ 全エージェントClaude Code起動完了"
echo ""

# STEP 4: 環境確認・表示
log_info "🔍 環境確認中..."

echo ""
echo "📊 SavingsGoalアプリ開発組織セットアップ結果:"
echo "============================================="

# tmuxセッション確認
echo "📺 Tmux Sessions:"
tmux list-sessions
echo ""

# 組織構成表示
echo "🏢 開発組織構成（5分割統合レイアウト）:"
echo "  📺 all-agents window (5分割):"
echo "    Pane 0: 👑 PRESIDENT           - SavingsGoalアプリ開発統括責任者"
echo "    Pane 1: 👨‍💻 boss1 (UI_BOSS)     - UI/UX統括、Figma+Flutter UI管理"
echo "    Pane 2: 🎨 worker1 (FIGMA)      - デザイン担当、Material 3準拠"
echo "    Pane 3: 📱 worker2 (FLUTTER1)   - UI実装担当、Widget開発"
echo "    Pane 4: 💾 worker3 (DB)         - データベース担当、SQLite管理"
echo ""
echo "📋 レイアウト:"
echo "  ┌─────────────┬─────────────┐"
echo "  │ PRESIDENT   │ boss1       │"
echo "  ├─────────────┼─────────────┤"
echo "  │ worker1     │ worker2     │ worker3"
echo "  └─────────────┴─────────────┘"

echo ""
log_success "🎉 SavingsGoalアプリ開発組織セットアップ完了！"
echo ""
echo "📋 使用方法:"
echo "  1. 🔗 セッション接続:"
echo "     tmux attach-session -t $SESSION"
echo "     # 5分割画面が表示されます"
echo ""
echo "  2. 🖱️ ペイン移動（マウス対応）:"
echo "     # マウスクリックで各ペインに移動可能"
echo "     # または Ctrl+b → ↑↓←→ でペイン移動"
echo ""
echo "  3. 🚀 自動通信テスト:"
echo "     ./agent-send.sh boss1 'テストメッセージ：自動受信確認'"
echo "     ./agent-send.sh worker1 'テストメッセージ：作業指示テスト'"
echo ""
echo "  3. 📜 指示書確認:"
echo "     instructions/president.md  - PRESIDENT指示書"
echo "     instructions/boss.md       - boss1指示書"
echo "     instructions/worker.md     - worker指示書"
echo ""
echo "  4. 🎯 開発開始:"
echo "     ./agent-send.sh president '【SavingsGoalアプリ開発開始指示】プロジェクト開始してください'"
echo ""
echo "  5. 📊 監視・ログ:"
echo "     tail -f logs/send_log.txt  - 通信ログ監視"
echo "     ./agent-send.sh --list     - エージェント一覧"