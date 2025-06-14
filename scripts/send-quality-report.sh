#!/bin/bash

# 品質レポート送信スクリプト

# Slack webhook URLs (環境変数から取得)
SLACK_DEV_WEBHOOK=${SLACK_WEBHOOK_URL_DEV:-""} 
SLACK_ALERTS_WEBHOOK=${SLACK_WEBHOOK_URL_ALERTS:-""} 

# 現在時刻
TIMESTAMP=$(date +"%Y-%m-%d %H:%M JST")

# 品質レポート内容
QUALITY_REPORT=$(cat << 'EOF'
{
  "text": "🔍 品質チェックレポート",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*🔍 品質チェックレポート*\n📅 実行日時: '"$TIMESTAMP"'"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*✅ 正常項目:*\n• Flutter環境: インストール済み (v3.32.4)\n• 静的解析: エラー0件 ✨\n• VS Code: 2バージョン検出\n• Web開発環境: Chrome利用可能\n• ネットワークリソース: 全て利用可能"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*⚠️ 警告項目:*\n• Android SDK: 未インストール\n• Xcode: 未インストール (iOS開発不可)\n• CocoaPods: 未インストール\n• Android Studio: 未インストール"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*❌ エラー項目:*\n• テスト失敗: MultiProvider設定エラー (children.isNotEmpty assertion failed)\n• テストカバレッジ: 計測不可 (テスト失敗により)"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*📊 テストカバレッジ:* 0% (テスト実行失敗)"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*🎯 推奨アクション:*\n1. *緊急*: main.dart:14 のMultiProvider設定を修正 (providers配列が空)\n2. *重要*: テスト修正後、カバレッジ80%以上を目指す\n3. *推奨*: iOS/Android開発環境のセットアップ"
      }
    }
  ]
}
EOF
)

# アラート内容（エラーがある場合のみ）
ALERT_MESSAGE=$(cat << 'EOF'
{
  "text": "🚨 品質チェックでエラーが検出されました",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*🚨 品質チェックアラート*\n<!channel> 緊急対応が必要です"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*❌ 検出されたエラー:*\n• MultiProvider設定エラー: main.dart:14\n• テスト実行失敗: アプリ起動テスト\n• カバレッジ計測不可"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*🔧 対応方法:*\n1. `src/lib/main.dart` の14行目でMultiProviderにprovidersを追加\n2. テストを再実行して動作確認\n3. GitHub Issue #1 を参照"
      }
    }
  ]
}
EOF
)

# Slackに送信（webhook URLが設定されている場合）
if [ -n "$SLACK_DEV_WEBHOOK" ]; then
    echo "📤 #savings-app-dev に品質レポートを送信中..."
    curl -X POST -H 'Content-type: application/json' \
         --data "$QUALITY_REPORT" \
         "$SLACK_DEV_WEBHOOK"
    echo -e "\n✅ 送信完了"
fi

if [ -n "$SLACK_ALERTS_WEBHOOK" ]; then
    echo "🚨 #savings-app-alerts にアラートを送信中..."
    curl -X POST -H 'Content-type: application/json' \
         --data "$ALERT_MESSAGE" \
         "$SLACK_ALERTS_WEBHOOK"
    echo -e "\n✅ 送信完了"
fi

# GitHub Issue作成スクリプトを呼び出し
echo "📝 GitHub Issueを作成中..."
bash $(dirname "$0")/create-github-issues.sh

echo "✅ 品質レポート処理完了"