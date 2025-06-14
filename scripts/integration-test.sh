#!/bin/bash

echo "🧪 統合テスト開始..."

# 1. Slack通知テスト
echo "📱 Slack通知テスト..."
claude << 'TEST_PROMPT'
Slack MCPを使用してテストメッセージを送信:
チャンネル: #savings-app-dev
メッセージ: "🧪 Phase 1.5 統合テスト実行中... 全システム正常動作確認"
TEST_PROMPT

sleep 2

# 2. GitHub連携テスト
echo "🔗 GitHub連携テスト..."
echo "# Integration Test $(date)" > test-integration.md
git add test-integration.md
git commit -m "Integration test: Phase 1.5 MCP詳細設定完了"
git push origin main

# 3. エージェント通信テスト
echo "🤖 エージェント通信テスト..."
./scripts/agent-communication.sh

# 4. 品質チェックテスト
echo "🔍 品質チェックテスト..."
./scripts/quality-check.sh

echo "✅ 統合テスト完了！"
echo "📊 Slackで結果を確認してください"
