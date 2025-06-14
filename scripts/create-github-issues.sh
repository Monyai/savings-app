#!/bin/bash

# GitHub Issue作成スクリプト

# GitHub CLI (gh) がインストールされているか確認
if ! command -v gh &> /dev/null; then
    echo "⚠️ GitHub CLI (gh) がインストールされていません"
    echo "インストール方法: brew install gh"
    exit 1
fi

# 認証状態を確認
if ! gh auth status &> /dev/null; then
    echo "⚠️ GitHub CLIが認証されていません"
    echo "実行: gh auth login"
    exit 1
fi

echo "📝 GitHub Issueを作成中..."

# Issue 1: MultiProvider設定エラー
gh issue create \
    --title "🐛 MultiProvider設定エラー: providers配列が空" \
    --body "$(cat <<'EOF'
## 問題の概要
テスト実行時にMultiProviderでエラーが発生しています。

## エラー内容
```
'package:nested/nested.dart': Failed assertion: line 71 pos 16: 'children.isNotEmpty': is not true.
```

## 発生箇所
- ファイル: `src/lib/main.dart`
- 行番号: 14行目
- 該当コード: `MultiProvider`の初期化部分

## 原因
MultiProviderのproviders配列が空になっているため、アサーションエラーが発生。

## 修正方法
1. main.dartのMultiProviderに必要なProviderを追加
2. 最低限、以下のようなProviderを追加することを推奨:
   ```dart
   MultiProvider(
     providers: [
       // TODO: 必要なProviderを追加
       // 例: ChangeNotifierProvider(create: (_) => SavingsGoalProvider()),
     ],
     child: MaterialApp(...),
   )
   ```

## 優先度
- 🔴 **緊急** - テストが全て失敗するため、開発に支障あり

## ラベル
- bug
- high-priority
- test-failure
EOF
)" \
    --label "bug" \
    --label "high-priority" \
    --label "test-failure" || echo "Issue 1作成失敗"

# Issue 2: 開発環境セットアップ
gh issue create \
    --title "📱 iOS/Android開発環境のセットアップ" \
    --body "$(cat <<'EOF'
## 概要
現在、iOS/Android向けのビルド環境が整っていません。

## 未インストールのツール
### Android開発
- [ ] Android SDK
- [ ] Android Studio

### iOS開発
- [ ] Xcode
- [ ] CocoaPods

## セットアップ手順
### Android
1. Android Studioをダウンロード: https://developer.android.com/studio
2. 初回起動時にAndroid SDKをインストール
3. `flutter config --android-sdk /path/to/sdk` でパスを設定

### iOS (macOSのみ)
1. App StoreからXcodeをインストール
2. 以下のコマンドを実行:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```
3. CocoaPodsをインストール:
   ```bash
   sudo gem install cocoapods
   ```

## 優先度
- 🟡 **中** - Web開発は可能だが、モバイル開発には必須

## ラベル
- enhancement
- setup
- documentation
EOF
)" \
    --label "enhancement" \
    --label "setup" \
    --label "documentation" || echo "Issue 2作成失敗"

# Issue 3: テストカバレッジ改善
gh issue create \
    --title "📊 テストカバレッジを80%以上に改善" \
    --body "$(cat <<'EOF'
## 現状
- 現在のカバレッジ: 0% (テスト失敗により計測不可)
- 目標カバレッジ: 80%以上

## 必要なアクション
1. [ ] Issue #1 のMultiProviderエラーを修正
2. [ ] 既存のwidget_test.dartを修正
3. [ ] 各モデルクラスのユニットテストを追加
4. [ ] 各画面のウィジェットテストを追加
5. [ ] 統合テストの追加を検討

## テスト対象の優先順位
1. **models/** - データモデルのユニットテスト
2. **services/** - ビジネスロジックのユニットテスト
3. **widgets/** - UIコンポーネントのウィジェットテスト
4. **screens/** - 画面全体の統合的なテスト

## カバレッジ確認方法
```bash
cd src
flutter test --coverage
lcov --summary coverage/lcov.info
```

## 優先度
- 🟡 **中** - 品質保証のために重要だが、開発は継続可能

## ラベル
- testing
- quality
- enhancement
EOF
)" \
    --label "testing" \
    --label "quality" \
    --label "enhancement" || echo "Issue 3作成失敗"

echo "✅ GitHub Issue作成処理完了"