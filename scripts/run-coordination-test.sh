#!/bin/bash

SESSION="savings-app-dev"

echo "🧪 マルチエージェント連携テスト開始..."

# Phase A: PRESDENTによる戦略的企画
echo "📋 Phase A: 戦略的企画フェーズ"
tmux send-keys -t $SESSION:0.0 "
echo '👑 PRESIDENT: 貯金ゲージ機能開発の戦略的企画を開始'
claude << 'PRESIDENT_PLANNING'
【マルチエージェント連携テスト】貯金ゲージ機能開発

あなたは PRESIDENT として以下を実行してください：

1. 要件分析・技術仕様策定
   - 縦スクロール対応貯金ゲージ
   - ピンチイン/アウト操作
   - マイルストーン表示機能
   - Material 3準拠デザイン

2. 作業分割判断
   - UI/UX領域 (BOSS_UI担当)
   - データ・ロジック領域 (BOSS_BACKEND担当)
   - 相互依存関係の整理

3. 両BOSSへの指示書作成
   以下のフォーマットでBOSSに指示を送信：
   
   BOSS_UI向け指示:
   tmux send-keys -t $SESSION:0.1 '[PRESIDENT → UI_BOSS] 貯金ゲージUI設計・実装指示: 詳細要件...' C-m
   
   BOSS_BACKEND向け指示:
   tmux send-keys -t $SESSION:0.2 '[PRESIDENT → BACKEND_BOSS] ゲージ計算ロジック・データ設計指示: 詳細要件...' C-m

4. Slack進捗開始報告
   \"🧪 連携テスト開始: 貯金ゲージ機能開発でマルチエージェント協調動作をテスト中\"

実行開始してください。
PRESIDENT_PLANNING
" C-m

# 30秒待機（PRESIDENT作業完了待ち）
echo "⏰ PRESIDENT企画作業完了待ち (30秒)..."
sleep 30

# Phase B: BOSS連携調整
echo "📋 Phase B: BOSS間連携調整フェーズ"

# BOSS間の調整を指示
tmux send-keys -t $SESSION:0.1 "
claude << 'BOSS_UI_COORDINATION'
PRESIDENT から指示を受けたBOSS_UIとして以下を実行：

1. PRESIDENT指示の詳細分析
2. UI/UX要件の具体化
3. BOSS_BACKENDとの依存関係確認

BOSS_BACKENDとの調整が必要な場合：
tmux send-keys -t $SESSION:0.2 '[UI_BOSS → BACKEND_BOSS] 調整依頼: データ構造・API要件確認' C-m

その後、WORKER_FIGMAに具体的タスク指示：
tmux send-keys -t $SESSION:0.3 '[UI_BOSS → FIGMA] タスク指示: 貯金ゲージデザイン作成' C-m

実行してください。
BOSS_UI_COORDINATION
" C-m

tmux send-keys -t $SESSION:0.2 "
claude << 'BOSS_BACKEND_COORDINATION'
PRESIDENT から指示を受けたBOSS_BACKENDとして以下を実行：

1. データ構造・ロジック要件分析
2. UI要件との整合性確認
3. 技術的制約・リスクの洗い出し

BOSS_UIとの調整が必要な場合：
tmux send-keys -t $SESSION:0.1 '[BACKEND_BOSS → UI_BOSS] 調整回答: データ構造制約・API仕様' C-m

PRESIDENT への中間報告：
tmux send-keys -t $SESSION:0.0 '[BACKEND_BOSS → PRESIDENT] 設計完了報告・技術的考慮事項' C-m

実行してください。
BOSS_BACKEND_COORDINATION
" C-m

# 60秒待機（BOSS調整完了待ち）
echo "⏰ BOSS間調整完了待ち (60秒)..."
sleep 60

# Phase C: WORKER実装・連携
echo "📋 Phase C: WORKER実装連携フェーズ"

tmux send-keys -t $SESSION:0.3 "
claude << 'WORKER_FIGMA_EXECUTION'
BOSS_UIからの指示を受けたWORKER_FIGMAとして実装実行：

1. Material 3準拠の貯金ゲージデザイン作成
2. 縦スクロール対応プロトタイプ
3. ピンチ操作のインタラクション設計

作業進捗をBOSS_UIに定期報告：
tmux send-keys -t $SESSION:0.1 '[FIGMA → UI_BOSS] 進捗報告: デザイン作業状況' C-m

完了時の成果報告：
tmux send-keys -t $SESSION:0.1 '[FIGMA → UI_BOSS] 完了報告: Figmaプロトタイプ完成・レビュー依頼' C-m

実行開始してください。
WORKER_FIGMA_EXECUTION
" C-m

tmux send-keys -t $SESSION:0.4 "
claude << 'WORKER_FLUTTER1_EXECUTION'
BOSS_UIからの指示を受けた（または今後受ける）WORKER_FLUTTER1として：

1. WORKER_FIGMAのデザイン完成待ち
2. Flutter Widget実装準備
3. 必要に応じてFIGMAとの直接調整

調整が必要な場合：
tmux send-keys -t $SESSION:0.3 '[FLUTTER1 → FIGMA] 実装相談: デザイン詳細確認' C-m

進捗報告：
tmux send-keys -t $SESSION:0.4 "
claude << 'WORKER_FLUTTER1_EXECUTION'
BOSS_UIからの指示を受けた（または今後受ける）WORKER_FLUTTER1として：

1. WORKER_FIGMAのデザイン完成待ち
2. Flutter Widget実装準備
3. 必要に応じてFIGMAとの直接調整

調整が必要な場合：
tmux send-keys -t $SESSION:0.3 '[FLUTTER1 → FIGMA] 実装相談: デザイン詳細確認' C-m

進捗報告：
tmux send-keys -t $SESSION:0.1 '[FLUTTER1 → UI_BOSS] 準備完了・実装開始待ち' C-m

実行してください。
WORKER_FLUTTER1_EXECUTION
" C-m

# 90秒待機（WORKER作業進行待ち）
echo "⏰ WORKER実装作業進行待ち (90秒)..."
sleep 90

# Phase D: 品質チェック・統合フェーズ
echo "📋 Phase D: 品質チェック・統合フェーズ"

# BOSS品質チェック指示
tmux send-keys -t $SESSION:0.1 "
claude << 'BOSS_UI_QUALITY_CHECK'
BOSS_UIとして品質チェック・統合作業を実行：

1. WORKER成果物の品質レビュー
2. Material 3準拠性確認
3. ユーザビリティ評価
4. Flutter実装品質確認

品質チェック結果をPRESIDENTに報告：
tmux send-keys -t $SESSION:0.0 '[UI_BOSS → PRESIDENT] 品質チェック完了報告: 貯金ゲージUI統合準備完了' C-m

問題がある場合はWORKERに修正指示：
tmux send-keys -t $SESSION:0.3 '[UI_BOSS → FIGMA] 修正指示: 品質改善要求' C-m

実行してください。
BOSS_UI_QUALITY_CHECK
" C-m

tmux send-keys -t $SESSION:0.2 "
claude << 'BOSS_BACKEND_INTEGRATION'
BOSS_BACKENDとして統合準備・品質確認：

1. データ構造整合性確認
2. 計算ロジック精度確認
3. UI要件との整合性最終チェック

PRESIDENT への統合準備完了報告：
tmux send-keys -t $SESSION:0.0 '[BACKEND_BOSS → PRESIDENT] バックエンド統合準備完了・データ整合性確認済み' C-m

実行してください。
BOSS_BACKEND_INTEGRATION
" C-m

# 60秒待機（品質チェック完了待ち）
echo "⏰ 品質チェック完了待ち (60秒)..."
sleep 60

# Phase E: PRESIDENT最終統合・人間報告
echo "📋 Phase E: 最終統合・報告フェーズ"

tmux send-keys -t $SESSION:0.0 "
claude << 'PRESIDENT_FINAL_INTEGRATION'
PRESIDENTとして最終統合・人間報告を実行：

1. 両BOSSからの報告統合
2. 全体品質・整合性最終確認
3. 成果物の統合評価
4. 連携テスト結果分析

Slack MCPを使用して詳細レポート送信：
チャンネル: #savings-app-dev

レポート内容：
\"🧪 【マルチエージェント連携テスト結果】
📋 テストシナリオ: 貯金ゲージ機能開発
⏰ 実行時間: [開始時刻] → [完了時刻]

📊 連携評価:
✅ 成功した連携:
- PRESIDENT → BOSS指示: [評価]
- BOSS → WORKER管理: [評価]
- WORKER間協調: [評価]
- 品質チェックサイクル: [評価]

⚠️ 改善点:
- [発見された課題]
- [提案する改善策]

🎯 次回テスト計画:
- [より複雑なシナリオでの検証計画]

💬 人間判断依頼:
- [組織構造の調整提案]
- [権限・役割の見直し提案]\"

GitHub MCPでテスト結果をissueとして記録も実行してください。

実行完了後「連携テスト完了」と応答してください。
PRESIDENT_FINAL_INTEGRATION
" C-m

echo "✅ 連携テスト全フェーズ指示完了"
echo "📊 各paneでの作業進行状況を監視してください"
echo "📱 Slackでの進捗報告も確認してください"
