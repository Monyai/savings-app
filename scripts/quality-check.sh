#!/bin/bash

# 自動品質チェックシステム

echo "🔍 品質チェック開始..."

# Flutter 解析
echo "📱 Flutter Doctor チェック..."
cd src
flutter doctor --verbose > ../logs/flutter-doctor.log 2>&1
flutter analyze > ../logs/flutter-analyze.log 2>&1

# テスト実行
echo "🧪 テスト実行..."
flutter test --coverage > ../logs/test-results.log 2>&1

# カバレッジ確認
echo "📊 カバレッジ確認..."
if command -v lcov &> /dev/null; then
    lcov --summary coverage/lcov.info > ../logs/coverage-summary.log 2>&1
fi

cd ..

# Claude Code で結果分析
claude << 'CLAUDE_PROMPT'
以下のログファイルを分析して品質レポートを作成してください:

1. logs/flutter-doctor.log - Flutter環境状況
2. logs/flutter-analyze.log - 静的解析結果  
3. logs/test-results.log - テスト実行結果
4. logs/coverage-summary.log - テストカバレッジ

分析後、以下を実行:
1. Slack #savings-app-dev に品質レポート送信
2. 重要な問題があれば #savings-app-alerts にアラート
3. GitHub Issues に自動的に品質改善タスク作成（必要に応じて）

レポート形式:
**🔍 品質チェックレポート**
📅 実行日時: [現在時刻]
✅ 正常項目: [OK項目一覧]
⚠️ 警告項目: [要注意項目]
❌ エラー項目: [修正必要項目]
📊 テストカバレッジ: [パーセンテージ]
🎯 推奨アクション: [次に取るべき行動]
CLAUDE_PROMPT

echo "✅ 品質チェック完了"
