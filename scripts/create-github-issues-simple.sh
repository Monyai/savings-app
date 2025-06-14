#!/bin/bash

# GitHub Issue作成スクリプト（シンプル版）

echo "📝 GitHub Issueを作成中..."

# Issue 1: MultiProvider設定エラー
gh issue create \
    --title "🐛 MultiProvider設定エラー: providers配列が空" \
    --body "## 問題の概要
テスト実行時にMultiProviderでエラーが発生しています。

## エラー内容
\`\`\`
'package:nested/nested.dart': Failed assertion: line 71 pos 16: 'children.isNotEmpty': is not true.
\`\`\`

## 発生箇所
- ファイル: \`src/lib/main.dart\`
- 行番号: 14行目

## 修正方法
MultiProviderのproviders配列に必要なProviderを追加する

## 優先度
🔴 **緊急** - テストが全て失敗するため" \
    --label "bug" && echo "✅ Issue 1 作成成功" || echo "❌ Issue 1 作成失敗"

# Issue 2: 開発環境セットアップ
gh issue create \
    --title "📱 iOS/Android開発環境のセットアップ" \
    --body "## 概要
iOS/Android向けのビルド環境が整っていません。

## 未インストールのツール
- Android SDK
- Android Studio  
- Xcode
- CocoaPods

## 優先度
🟡 **中** - Web開発は可能だが、モバイル開発には必須" \
    --label "enhancement" && echo "✅ Issue 2 作成成功" || echo "❌ Issue 2 作成失敗"

# Issue 3: テストカバレッジ改善  
gh issue create \
    --title "📊 テストカバレッジを80%以上に改善" \
    --body "## 現状
- 現在のカバレッジ: 0% (テスト失敗により計測不可)
- 目標カバレッジ: 80%以上

## 必要なアクション
1. Issue #1 のMultiProviderエラーを修正
2. 各種テストを追加

## 優先度
🟡 **中** - 品質保証のために重要" \
    --label "enhancement" && echo "✅ Issue 3 作成成功" || echo "❌ Issue 3 作成失敗"

echo "✅ GitHub Issue作成処理完了"