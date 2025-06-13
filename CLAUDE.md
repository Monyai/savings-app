# 目標貯金アプリ開発プロジェクト

## プロジェクト概要
- **名前**: SavingsGoal (仮)
- **目標**: iOS/Android対応の目標貯金管理アプリ
- **技術スタック**: Flutter + Dart + SQLite
- **開発手法**: Claude Code マルチエージェント並列開発

## 主要機能
1. **貯金ゲージ表示**: 縦スクロール対応、視覚的進捗表示
2. **目標設定**: 複数目標の階層管理、チェックポイント設定
3. **入出金管理**: 金額入力、履歴管理、カテゴリ分類
4. **ピンチ操作**: ズームイン/アウトでスケール調整
5. **購入処理**: 目標達成時の購入ボタン、目標からの削除

## 開発組織 (3層構造)
### PRESIDENT (統括責任者)
- 全体品質管理・戦略判断
- 人間への進捗報告
- 最終的な設計判断

### BOSS レベル (中間管理)
- **BOSS_UI**: UI/UX設計統括、Figma連携管理
- **BOSS_BACKEND**: データ・ロジック統括、アーキテクチャ決定

### WORKER レベル (実装担当)
- **WORKER_FIGMA**: Figmaデザイン・プロトタイプ作成
- **WORKER_FLUTTER1**: UI実装・Widget作成
- **WORKER_FLUTTER2**: ビジネスロジック・状態管理
- **WORKER_DB**: データ永続化・SQLite操作

## 技術仕様
- **フレームワーク**: Flutter 3.x
- **状態管理**: Provider または Riverpod
- **データベース**: SQLite (sqflite)
- **UI**: Material 3 Design準拠
- **テスト**: 単体テスト + Widget テスト (カバレッジ80%以上)

## 品質基準
- Dart Analyzer エラー0件
- Flutter Doctor チェック全てOK
- コードレビュー必須 (BOSS → WORKER)
- Git コミット粒度: 機能単位
- 日本語コメント推奨

📁 プロジェクト全体構造:
savings-app/
└── src/                                    # アプリケーションソースコード
    ├── lib/                                # Dartライブラリコード
    │   ├── main.dart                       # 🚀 アプリケーションエントリーポイント
    │   │
    │   ├── models/                         # 📊 データモデル層
    │   │   ├── savings_goal.dart           # 貯金目標のデータ構造
    │   │   ├── transaction.dart            # 取引記録のデータ構造
    │   │   └── milestone.dart              # マイルストーンのデータ構造
    │   │
    │   ├── screens/                        # 📱 画面・ページ層
    │   │   ├── home_screen.dart            # メイン画面（ダッシュボード）
    │   │   ├── goal_setting_screen.dart    # 目標設定画面
    │   │   └── transaction_screen.dart     # 取引記録画面
    │   │
    │   ├── widgets/                        # 🧩 UIコンポーネント層
    │   │   ├── savings_gauge.dart          # 🎯 貯金進捗ゲージ（重要）
    │   │   ├── goal_milestone.dart         # マイルストーン表示コンポーネント
    │   │   └── amount_input.dart           # 金額入力コンポーネント
    │   │
    │   ├── services/                       # ⚙️ ビジネスロジック層
    │   │   ├── database_service.dart       # データベース操作サービス
    │   │   ├── calculation_service.dart    # 計算処理サービス
    │   │   └── storage_service.dart        # ローカルストレージサービス
    │   │
    │   └── utils/                          # 🔧 ユーティリティ層
    │       └── (共通関数、定数、拡張メソッドなど)
    │
    └── test/                               # 🧪 テストコード
        └── (ユニットテスト、ウィジェットテスト、統合テスト)


## 重要な実装ポイント
1. **貯金ゲージ**: CustomPainter使用、滑らかなアニメーション
2. **ピンチ操作**: GestureDetector + Matrix4変換
3. **データ同期**: SQLite + Provider での状態管理
4. **パフォーマンス**: 大量データ対応、遅延読み込み

## 報告フォーマット
### WORKER → BOSS
[担当領域] タスク名: 進捗状況 ✅ 完了: 具体的な成果 ⚠️ 課題: 発生した問題 📝 次回: 次のアクション 📁 場所: ファイルパス


### BOSS → PRESIDENT  
[BOSS_領域] チーム進捗: X% ✅ 完了項目リスト ⚠️ 課題と対応策 📈 品質状況 ⏰ 完了予定

