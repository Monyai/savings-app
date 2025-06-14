#!/bin/bash

# 現在のcrontabをバックアップ
crontab -l > /tmp/crontab_backup.txt 2>/dev/null || true

# 新しいcron設定を追加
cat >> /tmp/crontab_new.txt << 'CRON_EOF'

# Savings App 自動化タスク
# 2時間毎のエージェント進捗報告
0 */2 * * * cd ~/dev/savings-app && ./scripts/agent-communication.sh

# 6時間毎の品質チェック
0 */6 * * * cd ~/dev/savings-app && ./scripts/quality-check.sh

# 毎日午前9時に日次レポート
0 9 * * * cd ~/dev/savings-app && claude -c "GitHub MCPとSlack MCPを使用して昨日の開発活動サマリーを #savings-app-dev に送信"

# 毎週月曜日午前10時にウィークリーレポート
0 10 * * 1 cd ~/dev/savings-app && claude -c "先週の開発進捗、課題、来週の計画をまとめたウィークリーレポートを #savings-app-dev に送信"
CRON_EOF

# crontab適用
cat /tmp/crontab_backup.txt /tmp/crontab_new.txt | crontab -

echo "✅ 定期実行設定完了"
crontab -l
