#!/bin/bash

echo "🧪 並列開発成果物統合テスト実行..."

# Flutter プロジェクトの基本チェック
cd src

echo "📱 Flutter Doctor チェック..."
flutter doctor

echo "📊 依存関係チェック..."
flutter pub get

echo "🔍 静的解析チェック..."
flutter analyze > ../logs/integration-analysis.log 2>&1

echo "🧪 テスト実行..."
flutter test > ../logs/integration-test.log 2>&1

echo "🏗️ ビルドテスト..."
flutter build apk --debug > ../logs/integration-build.log 2>&1

cd ..

# Claude Code で統合結果分析
claude << 'INTEGRATION_ANALYSIS'
並列開発の統合テスト結果を分析してください：

分析対象ログ:
1. logs/integration-analysis.log - 静的解析結果
2. logs/integration-test.log - テスト実行結果  
3. logs/integration-build.log - ビルド結果

分析項目:
1. 各Track成果物の技術的整合性
2. 統合時の競合・問題の有無
3. 品質基準達成度
4. パフォーマンス影響
5. 次フェーズへの準備状況

GitHub MCPで統合テスト結果をIssueに記録し、
Slack #savings-app-dev に詳細レポートを送信してください。

実行してください。
INTEGRATION_ANALYSIS

echo "✅ 統合テスト分析完了"
