# シナリオ1: 貯金ゲージ機能開発 - マルチエージェント連携テスト

## 概要
貯金ゲージの設計・実装を通じて、3層組織の連携動作を検証

## 成功条件
1. PRESIDENT → BOSS への適切なタスク分解・指示
2. BOSS → WORKER への詳細タスク割り当て
3. WORKER間の協調動作（FigmaとFlutter実装の連携）
4. 品質チェック・フィードバックサイクル
5. 全体統合・PRESIDENTの最終承認

## フェーズ別詳細

### Phase A: 戦略的企画（PRESIDENT主導）
1. 要件整理・技術仕様策定
2. UI/バックエンド作業分割判断
3. 両BOSS への指示書作成

### Phase B: 設計・計画（BOSS主導）
1. BOSS_UI: Figmaデザイン要件定義
2. BOSS_BACKEND: データ構造・計算ロジック設計
3. 相互依存関係の調整

### Phase C: 実装（WORKER実行）
1. WORKER_FIGMA: プロトタイプ作成
2. WORKER_FLUTTER1: UI実装
3. 実装レビュー・調整サイクル

### Phase D: 統合・品質保証
1. 各BOSS品質チェック
2. PRESIDENT最終レビュー
3. Slack進捗報告・人間報告

## 期待される通信フロー
PRESIDENT → BOSS_UI: "貯金ゲージ設計・実装指示" PRESIDENT → BOSS_BACKEND: "ゲージ計算ロジック仕様策定"

BOSS_UI → WORKER_FIGMA: "縦スクロール対応ゲージデザイン作成" BOSS_UI → WORKER_FLUTTER1: "ピンチ操作Widget実装"

WORKER_FIGMA → BOSS_UI: "デザイン完了報告・レビュー依頼" BOSS_UI → PRESIDENT: "UI設計完了・統合準備OK"

PRESIDENT: "フェーズ完了・人間報告実行"

EOF

cat > tests/multi-agent/scenario-2-complex-coordination.md << 'EOF'
# シナリオ2: 複雑な相互依存タスク - 高度連携テスト

## 概要
データ構造変更を伴うUI改修により、全レイヤーが協調して作業する複雑シナリオ

## 想定状況
「目標設定画面に、階層的サブゴール機能を追加」
→ データ構造変更・UI大幅改修・ロジック追加が必要

## 協調ポイント
1. BOSS_BACKEND → BOSS_UI: データ構造変更によるUI影響説明
2. BOSS_UI → BOSS_BACKEND: UI要件によるデータ制約要求
3. WORKER同士のリアルタイム調整
4. PRESIDENTによる優先度・リソース配分調整

## 期待される高度な連携
- クロスチーム調整（UI ↔ Backend）
- 並列作業での競合回避
- リアルタイムな進捗調整
- ボトルネック検出・回避

PRESIDENT → BOSS_UI: "貯金ゲージ設計・実装指示" PRESIDENT → BOSS_BACKEND: "ゲージ計算ロジック仕様策定"

BOSS_UI → WORKER_FIGMA: "縦スクロール対応ゲージデザイン作成" BOSS_UI → WORKER_FLUTTER1: "ピンチ操作Widget実装"

WORKER_FIGMA → BOSS_UI: "デザイン完了報告・レビュー依頼" BOSS_UI → PRESIDENT: "UI設計完了・統合準備OK"

PRESIDENT: "フェーズ完了・人間報告実行"

EOF

cat > tests/multi-agent/scenario-2-complex-coordination.md << 'EOF'
# シナリオ2: 複雑な相互依存タスク - 高度連携テスト

## 概要
データ構造変更を伴うUI改修により、全レイヤーが協調して作業する複雑シナリオ

## 想定状況
「目標設定画面に、階層的サブゴール機能を追加」
→ データ構造変更・UI大幅改修・ロジック追加が必要

## 協調ポイント
1. BOSS_BACKEND → BOSS_UI: データ構造変更によるUI影響説明
2. BOSS_UI → BOSS_BACKEND: UI要件によるデータ制約要求
3. WORKER同士のリアルタイム調整
4. PRESIDENTによる優先度・リソース配分調整

## 期待される高度な連携
- クロスチーム調整（UI ↔ Backend）
- 並列作業での競合回避
- リアルタイムな進捗調整
- ボトルネック検出・回避

