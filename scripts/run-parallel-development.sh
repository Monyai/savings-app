#!/bin/bash

SESSION="savings-app-dev"

echo "🚀 実開発並列タスク実行開始..."

# 新しいWORKER追加（DB担当）
echo "👷 WORKER_DB追加..."
tmux split-window -v -t $SESSION:0.4
tmux send-keys -t $SESSION:0.5 "
echo '💾 WORKER_DB初期化中...'
claude << 'WORKER_DB_INIT'
あなたは目標貯金アプリ開発プロジェクトのWORKER_DB（データベース担当）です。

専門領域:
- SQLite設計・実装
- データ永続化
- クエリ最適化
- データ整合性確保

上司: BOSS_BACKEND (pane 2)
報告方法: tmux send-keys -t $SESSION:0.2 '[DB] 報告内容' C-m

初期化完了後「WORKER_DB初期化完了」と応答してください。
WORKER_DB_INIT
" C-m

sleep 10

# Phase 1: 基盤実装並列開始
echo "📋 Phase 1: 基盤実装並列タスク開始"

# PRESIDENT が全体調整・タスク分散指示
tmux send-keys -t $SESSION:0.0 "
claude << 'PRESIDENT_PARALLEL_COORDINATION'
PRESIDENT として Phase 1 基盤実装の並列開発を統括します。

tasks/parallel-development/phase1-foundation.md を参照して、以下の並列タスクを各チームに指示：

【Track A: UI基盤 → BOSS_UI】
指示送信: tmux send-keys -t $SESSION:0.1 '[PRESIDENT → UI_BOSS] Phase1 UI基盤開発指示: Figmaデザインシステム + Flutter基本Widget並列実装' C-m

【Track B: データ基盤 → BOSS_BACKEND】  
指示送信: tmux send-keys -t $SESSION:0.2 '[PRESIDENT → BACKEND_BOSS] Phase1 データ基盤開発指示: データモデル + DB実装並列実行' C-m

【並列実行スケジュール】
- 3時間後: 中間進捗確認
- 6時間後: Track統合確認
- 8時間後: Phase1完了評価

Slack進捗開始報告:
「🚀 Phase1基盤実装並列開発開始！UI・データ基盤を同時構築中」

各BOSSからの進捗報告を待機し、適宜調整指示を行ってください。
PRESIDENT_PARALLEL_COORDINATION
" C-m

sleep 5

# BOSS_UI がTrack A管理開始
tmux send-keys -t $SESSION:0.1 "
claude << 'BOSS_UI_TRACK_A'
PRESIDENT指示を受けたBOSS_UIとして Track A (UI基盤) を統括：

【Track A 並列タスク管理】
A1: WORKER_FIGMA → デザインシステム構築
A2: WORKER_FLUTTER1 → Flutter基本Widget開発

WORKER_FIGMA への指示:
tmux send-keys -t $SESSION:0.3 '[UI_BOSS → FIGMA] A1タスク: Material 3デザインシステム構築開始' C-m

WORKER_FLUTTER1 への指示:
tmux send-keys -t $SESSION:0.4 '[UI_BOSS → FLUTTER1] A2タスク: Flutter基本Widget開発開始' C-m

【進捗管理スケジュール】
- 1時間毎に各WORKERから進捗報告
- 問題発生時は即座調整
- 3時間後にPRESIDENTへ中間報告

実行開始してください。
BOSS_UI_TRACK_A
" C-m

sleep 5

# BOSS_BACKEND がTrack B管理開始
tmux send-keys -t $SESSION:0.2 "
claude << 'BOSS_BACKEND_TRACK_B'
PRESIDENT指示を受けたBOSS_BACKENDとして Track B (データ基盤) を統括：

【Track B 並列タスク管理】
B1: WORKER_FLUTTER2 → データモデル設計・実装
B2: WORKER_DB → SQLite DB実装

WORKER_FLUTTER2 への指示:
tmux send-keys -t $SESSION:0.4 '[BACKEND_BOSS → FLUTTER2] B1タスク: 貯金・目標・取引データモデル実装開始' C-m

WORKER_DB への指示:
tmux send-keys -t $SESSION:0.5 '[BACKEND_BOSS → DB] B2タスク: SQLiteスキーマ設計・CRUD実装開始' C-m

【データ整合性確保】
- 両WORKER間のデータ構造統一
- 定期的な設計レビュー
- パフォーマンス要件確認

実行開始してください。
BOSS_BACKEND_TRACK_B
" C-m

sleep 5

# 各WORKER が並列作業開始
echo "👷 全WORKER並列作業開始指示..."

# WORKER_FIGMA: デザインシステム構築
tmux send-keys -t $SESSION:0.3 "
claude << 'WORKER_FIGMA_PARALLEL'
BOSS_UI指示によりA1タスク実行：Material 3デザインシステム構築

実装内容：
1. カラーパレット定義 (Primary, Secondary, Tertiary)
2. タイポグラフィシステム (Display, Headline, Title, Body, Label)  
3. コンポーネントライブラリ (Button, Card, Chip, etc.)
4. アイコンセット整備
5. 貯金アプリ専用コンポーネント設計

作業進捗を1時間毎に報告：
tmux send-keys -t $SESSION:0.1 '[FIGMA → UI_BOSS] A1進捗: デザインシステム構築状況' C-m

並列作業開始してください。
WORKER_FIGMA_PARALLEL
" C-m

# WORKER_FLUTTER1: Flutter基本Widget開発
tmux send-keys -t $SESSION:0.4 "
claude << 'WORKER_FLUTTER1_PARALLEL'
BOSS_UI指示によりA2タスク実行：Flutter基本Widget開発

実装内容：
1. アプリ基本構造 (main.dart, app.dart)
2. 共通Widgetライブラリ (CommonButton, CommonCard, etc.)
3. ナビゲーション実装 (BottomNavigationBar, Routes)
4. テーマ設定 (Material 3 Theme適用)
5. 基本画面構造 (Scaffold, AppBar)

FIGMA完成を待って連携：
tmux send-keys -t $SESSION:0.3 '[FLUTTER1 → FIGMA] デザインシステム完成時の連携方法確認' C-m

作業開始してください。
WORKER_FLUTTER1_PARALLEL
" C-m

# WORKER_DB: SQLite DB実装  
tmux send-keys -t $SESSION:0.5 "
claude << 'WORKER_DB_PARALLEL'
BOSS_BACKEND指示によりB2タスク実行：SQLite DB実装

実装内容：
1. データベーススキーマ設計
   - savings_goals テーブル
   - transactions テーブル  
   - milestones テーブル
   - settings テーブル
   
2. マイグレーション機能実装
3. 基本CRUD操作実装
4. インデックス設計・最適化
5. データ整合性制約設定

FLUTTER2との連携確認：
tmux send-keys -t $SESSION:0.4 '[DB → FLUTTER2] データ構造統一確認' C-m

作業開始してください。
WORKER_DB_PARALLEL
" C-m

echo "✅ 全エージェント並列作業開始完了"
echo "📊 3時間後に中間進捗確認予定"
echo "📱 Slackでリアルタイム進捗を監視してください"
