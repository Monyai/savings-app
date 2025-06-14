#!/bin/bash

SESSION="savings-app-dev"

echo "📊 並列開発進捗監視システム開始..."

# 進捗チェック関数
check_progress() {
    local hour=$1
    echo "⏰ [$hour時間経過] 進捗チェック実行中..."
    
    # PRESIDENT に進捗確認指示
    tmux send-keys -t $SESSION:0.0 "
    claude << 'PROGRESS_CHECK'
    PRESIDENT として$hour時間経過時点での進捗確認を実行：
    
    1. 各BOSSからの進捗報告要求
    進捗要求送信: tmux send-keys -t $SESSION:0.1 '[PRESIDENT] UI_BOSS進捗報告要求' C-m
    進捗要求送信: tmux send-keys -t $SESSION:0.2 '[PRESIDENT] BACKEND_BOSS進捗報告要求' C-m
    
    2. 遅延・問題の有無確認
    3. リソース再配分の必要性判断
    4. 次フェーズへの影響評価
    
    5. Slack進捗レポート送信:
    \"⏰ [$hour時間経過] 並列開発進捗レポート
    📋 Track A (UI): [進捗状況]
    📋 Track B (Data): [進捗状況]  
    ⚠️ 課題: [発見された問題]
    🎯 調整: [実施した調整]\"
    
    実行してください。
PROGRESS_CHECK
    " C-m
}

# 1時間毎の進捗チェック (最大8時間)
for hour in {1..8}; do
    echo "⏰ $hour 時間待機中..."
    sleep 3600  # 1時間 = 3600秒
    
    check_progress $hour
    
    # 特別チェック
    case $hour in
        3)
            echo "📊 【3時間チェックポイント】中間進捗確認"
            tmux send-keys -t $SESSION:0.0 "
            claude << 'MIDPOINT_CHECK'
            3時間中間チェックポイントとして特別確認：
            
            1. 当初計画との進捗比較
            2. Track間の依存関係影響確認
            3. 品質水準維持確認
            4. 残り時間での完成可能性評価
            
            必要に応じて：
            - タスク優先度変更
            - リソース再配分
            - スコープ調整
            
            Slack重要報告送信してください。
MIDPOINT_CHECK
            " C-m
            ;;
        6)
            echo "📊 【6時間チェックポイント】Track統合準備確認"
            tmux send-keys -t $SESSION:0.0 "
            claude << 'INTEGRATION_CHECK'
            6時間統合準備チェックポイント：
            
            1. Track A (UI基盤) 完成度確認
            2. Track B (データ基盤) 完成度確認
            3. Track間統合の技術的準備確認
            4. 残り2時間での統合完了可能性
            
            各BOSSに統合準備指示送信：
            tmux send-keys -t $SESSION:0.1 '[PRESIDENT] 統合準備開始指示' C-m
            tmux send-keys -t $SESSION:0.2 '[PRESIDENT] 統合準備開始指示' C-m
            
            実行してください。
INTEGRATION_CHECK
            " C-m
            ;;
        8)
            echo "🎯 【8時間完了】Phase1最終評価"
            tmux send-keys -t $SESSION:0.0 "
            claude << 'FINAL_EVALUATION'
            Phase1 最終評価・完了処理：
            
            1. 全Track成果物品質評価
            2. 統合テスト結果確認
            3. 当初目標達成度評価
            4. Phase2準備状況確認
            
            最終レポート作成：
            - GitHub Issues でPhase1完了報告
            - Slack詳細成果レポート
            - Phase2計画調整提案
            
            人間向け完了報告：
            「Phase1 基盤実装並列開発が完了しました。成果確認をお願いします。」
            
            実行してください。
FINAL_EVALUATION
            " C-m
            ;;
    esac
done

echo "✅ 8時間並列開発監視完了"
