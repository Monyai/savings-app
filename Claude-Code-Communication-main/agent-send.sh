#!/bin/bash

# 🚀 SavingsGoalアプリ開発組織 - Agent間自動通信システム
# 完全自動化メッセージ送信スクリプト

SESSION="savings-app-dev"

# エージェント→tmuxターゲット マッピング（5分割統合レイアウト）
get_agent_target() {
    case "$1" in
        "president") echo "$SESSION:all-agents.0" ;;
        "boss1") echo "$SESSION:all-agents.1" ;;
        "worker1") echo "$SESSION:all-agents.2" ;;
        "worker2") echo "$SESSION:all-agents.3" ;;
        "worker3") echo "$SESSION:all-agents.4" ;;
        *) echo "" ;;
    esac
}

# エージェント役割マッピング
get_agent_role() {
    case "$1" in
        "president") echo "PRESIDENT" ;;
        "boss1") echo "boss1 (UI_BOSS)" ;;
        "worker1") echo "worker1 (FIGMA)" ;;
        "worker2") echo "worker2 (FLUTTER1)" ;;
        "worker3") echo "worker3 (DB)" ;;
        *) echo "UNKNOWN" ;;
    esac
}

show_usage() {
    cat << EOF
🏢 SavingsGoalアプリ開発組織 - 自動通信システム

使用方法:
  $0 [エージェント名] [メッセージ]
  $0 --list
  $0 --status

利用可能エージェント:
  president - 👑 PRESIDENT (プロジェクト統括責任者)
  boss1     - 👨‍💻 boss1 (UI_BOSS) - UI/UX統括、Figma+Flutter UI管理
  worker1   - 🎨 worker1 (FIGMA) - デザイン担当、Material 3準拠
  worker2   - 📱 worker2 (FLUTTER1) - UI実装担当、Widget開発
  worker3   - 💾 worker3 (DB) - データベース担当、SQLite管理

使用例:
  $0 president "【SavingsGoalアプリ開発開始指示】プロジェクト開始してください"
  $0 boss1 "[PRESIDENT→UI_BOSS] 貯金ゲージ機能実装指示: 4時間でFigmaデザイン+Flutter実装完成"
  $0 worker1 "[UI_BOSS→FIGMA] 貯金ゲージ縦スクロールデザイン作成: 2時間で完成"
  $0 worker2 "[UI_BOSS→FLUTTER1] Material 3準拠Widget実装: 3時間で完成"
  $0 worker3 "[UI_BOSS→DB] SQLite貯金データ管理機能: 2時間で完成"

自動化機能:
  - 完全自動送信（許可不要）
  - 自動ログ記録
  - 自動応答システム連携
EOF
}

# エージェント一覧表示
show_agents() {
    echo "🏢 SavingsGoalアプリ開発組織構成（5分割統合レイアウト）:"
    echo "================================================="
    echo "  👑 president → $SESSION:all-agents.0  (PRESIDENT - プロジェクト統括責任者)"
    echo "  👨‍💻 boss1     → $SESSION:all-agents.1  (UI_BOSS - UI/UX統括、Figma+Flutter UI管理)"
    echo "  🎨 worker1   → $SESSION:all-agents.2  (FIGMA - デザイン担当、Material 3準拠)"
    echo "  📱 worker2   → $SESSION:all-agents.3  (FLUTTER1 - UI実装担当、Widget開発)"
    echo "  💾 worker3   → $SESSION:all-agents.4  (DB - データベース担当、SQLite管理)"
    echo ""
    echo "📊 セッション状態:"
    if tmux has-session -t $SESSION 2>/dev/null; then
        echo "  ✅ セッション '$SESSION' は稼働中"
        echo "  📺 接続: tmux attach-session -t $SESSION"
    else
        echo "  ❌ セッション '$SESSION' が見つかりません"
        echo "  🚀 起動: ./setup.sh"
    fi
}

# システム状態確認
show_status() {
    echo "📊 SavingsGoalアプリ開発組織 - システム状態:"
    echo "==========================================="

    # セッション確認
    if tmux has-session -t $SESSION 2>/dev/null; then
        echo "✅ メインセッション: 稼働中"
        echo "📋 ウィンドウ一覧:"
        tmux list-windows -t $SESSION
        echo ""
        echo "📋 ペイン一覧:"
        tmux list-panes -t $SESSION -a
    else
        echo "❌ メインセッション: 停止中"
        echo "🚀 起動コマンド: ./setup.sh"
    fi

    echo ""
    echo "📝 最新通信ログ (直近5件):"
    if [ -f logs/send_log.txt ]; then
        tail -5 logs/send_log.txt
    else
        echo "  ログファイルが見つかりません"
    fi
}

# ログ記録
log_send() {
    local agent="$1"
    local message="$2"
    local role=$(get_agent_role "$agent")
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    mkdir -p logs
    echo "[$timestamp] 📤 $role: SENT - \"$message\"" >> logs/send_log.txt
    echo "[$timestamp] 📤 送信完了: $role ← '$message'"
}

# 完全自動メッセージ送信
send_message() {
    local target="$1"
    local message="$2"
    local agent_name="$3"
    local role=$(get_agent_role "$agent_name")
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "📤 自動送信中: $role ← '$message'"

    # Claude Codeプロンプトクリア
    tmux send-keys -t "$target" C-c
    sleep 0.2

    # 完全自動化メッセージ送信（--dangerously-skip-permissions使用）
    local auto_message="
【🤖 自動受信メッセージ】
送信者: SavingsGoalアプリ開発組織自動通信システム
受信時刻: $timestamp
送信先: $role
内容: $message

このメッセージを確認し、適切に対応してください。
対応完了後は ./agent-send.sh で送信者に結果を報告してください。
"

    tmux send-keys -t "$target" "$auto_message" C-m
    sleep 0.3
}

# ターゲット存在確認
check_target() {
    local target="$1"
    local session_name="${target%%:*}"
    
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        echo "❌ セッション '$session_name' が見つかりません"
        return 1
    fi
    
    return 0
}

# メイン処理
main() {
    if [[ $# -eq 0 ]]; then
        show_usage
        exit 1
    fi

    # --listオプション
    if [[ "$1" == "--list" ]]; then
        show_agents
        exit 0
    fi

    # --statusオプション
    if [[ "$1" == "--status" ]]; then
        show_status
        exit 0
    fi
    
    if [[ $# -lt 2 ]]; then
        show_usage
        exit 1
    fi
    
    local agent_name="$1"
    local message="$2"
    
    # エージェントターゲット取得
    local target
    target=$(get_agent_target "$agent_name")
    
    if [[ -z "$target" ]]; then
        echo "❌ エラー: 不明なエージェント '$agent_name'"
        echo "利用可能エージェント: $0 --list"
        exit 1
    fi
    
    # ターゲット確認
    if ! check_target "$target"; then
        exit 1
    fi
    
    # 完全自動メッセージ送信
    send_message "$target" "$message" "$agent_name"

    # ログ記録
    log_send "$agent_name" "$message"

    echo "✅ 自動送信完了: $(get_agent_role "$agent_name") に '$message'"
    
    return 0
}

main "$@" 