#!/bin/bash

SESSION="savings-app-dev"

# PRESDENTから全組織への自動指示配信
auto_distribute_orders() {
    local task_type=$1
    local task_description="$2"
    
    echo "📢 PRESIDENT自動指示配信: $task_type"
    
    # PRESIDENT -> 両BOSS自動指示
    tmux send-keys -t $SESSION:0.0 "
    claude << 'AUTO_PRESIDENT_ORDER'
    PRESIDENT として「$task_type」タスクの自動指示配信を実行：
    
    ## 指示内容
    $task_description
    
    ## 自動配信実行
    ### BOSS_UI向け指示
    tmux send-keys -t $SESSION:0.1 '[PRESIDENT→UI_BOSS] $task_type: UI/UX領域担当部分の実装指示' C-m
    
    ### BOSS_BACKEND向け指示  
    tmux send-keys -t $SESSION:0.2 '[PRESIDENT→BACKEND_BOSS] $task_type: データ・ロジック領域担当部分の実装指示' C-m
    
    ## 30秒後に進捗確認自動実行
    30秒後に各BOSSからの受諾確認・詳細計画報告を要求します。
    
    実行してください。
AUTO_PRESIDENT_ORDER
    " C-m
}

# BOSS -> WORKER 自動指示システム
auto_boss_delegate() {
    local boss_pane=$1
    local boss_name=$2
    
    tmux send-keys -t $SESSION:0.$boss_pane "
    claude << 'AUTO_BOSS_DELEGATE'
    $boss_name として、PRESIDENT指示を受けて配下WORKERへの自動指示配信：
    
    ## 指示分解・配信
    PRESIDENT指示を分析し、担当WORKERに適切なタスク分割して自動指示送信
    
    ## 進捗自動監視
    各WORKER作業開始後、定期的な進捗確認・問題対応を自動実行
    
    ## PRESIDENT自動報告
    重要な進捗・問題発生時は即座にPRESIDENT報告
    
    自動指示配信を開始してください。
AUTO_BOSS_DELEGATE
    " C-m
}

# 使用例
auto_distribute_orders "貯金ゲージ機能実装" "縦スクロール対応の貯金ゲージ機能を4時間で実装。UI：Figmaデザイン+Flutter実装、Backend：計算ロジック+データ構造"

