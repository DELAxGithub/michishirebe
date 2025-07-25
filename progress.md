# みちしるべ開発進捗

## 現在の状況（2025-07-24）

### ✅ 完了した作業

#### 1. spec-driven developmentによる設計
- **要件定義**: 手続きの視覚化とドメイン知識の提供に焦点
- **設計書**: Flutter + Supabaseアーキテクチャ
- **実装計画**: 3週間のフェーズ別計画

#### 2. Flutterプロジェクト初期化
- Flutter Web専用プロジェクトとして作成
- 必要なパッケージをインストール済み：
  - supabase_flutter: バックエンド連携
  - flutter_riverpod: 状態管理
  - go_router: ルーティング
  - google_fonts: 日本語フォント

#### 3. 基本UI実装
- **手続き一覧画面**: 5つのライフステージをカード形式で表示
  - 入院準備
  - 介護申請
  - 施設選び
  - 看取り準備
  - 相続手続き
- **テーマ設定**: 高齢者向けの大きな文字（18px基準）
- **レスポンシブ対応**: スマホ・タブレット・PCに対応

#### 4. 手続きデータの網羅的な整理
- **記事から56件の手続きを抽出**
  - 実体験に基づく詳細な手続き情報
  - 「同意書50枚問題」「病院からの非同期電話」など実態を反映
- **CSVデータからSQL変換スクリプト作成**
  - `michishirube-tasks-csv.txt`: 56件の手続きマスターデータ
  - `convert_csv_to_sql.py`: CSV→SQL変換スクリプト
  - `seed_procedures.sql`: Supabase投入用SQLファイル
- **9つのライフステージに拡張**
  - 元気なうち、介護開始時、入院時、施設入居時、看取り準備
  - 逝去直後、葬儀後、相続手続き、実家管理

#### 5. Supabase統合完了（2025-07-24）
- **環境設定**
  - flutter_dotenv導入で環境変数管理
  - Supabase接続設定（URL、Anon Key）
- **データベース設計**
  - `michi_procedures`: 手続きマスターテーブル
  - `michi_tasks`: ユーザータスクテーブル
  - RLS設定とリアルタイム機能有効化
- **データアクセス層**
  - シンプルなモデルクラス（Procedure, Task）
  - SupabaseService: CRUD操作
  - Riverpodプロバイダーで状態管理

#### 6. タスク管理機能実装（2025-07-24）
- **タスク一覧画面**
  - ライフステージごとにグループ表示
  - チェックボックスで完了管理
  - 進捗率の表示
- **初回アクセス時の自動生成**
  - 56個の手続きを一括でタスク化
  - セッションIDベースの管理
- **リアルタイム同期**
  - Supabase Realtimeで自動更新
  - 複数デバイス間で即座に反映

#### 7. 共有機能実装（2025-07-24）
- **セッション管理**
  - SharedPreferencesでセッションID保存
  - URLパラメータからセッションID取得
- **共有URL生成**
  - `http://localhost:8080?session=xxxxx`形式
  - 家族間で同じタスクリストを共有

#### 8. ライフステージ詳細画面（2025-07-24）
- **手続き一覧表示**
  - カテゴリ別グループ表示（準備、手続き、情報収集など）
  - 優先度の色分け表示（高:赤、中:橙、低:緑）
- **手続きの追加/削除**
  - タスクへの追加/削除をワンタップで
  - 追加済みはチェックマークで表示
- **詳細情報モーダル**
  - 理由、必要書類、期限、担当窓口、ヒントを表示

### 🎯 現在の機能

1. **Supabase連携による本格的なデータ管理**
   - 56件の手続きマスターデータ
   - ユーザーごとのタスク管理
   - リアルタイム同期

2. **使いやすいUI/UX**
   - ボトムナビゲーション
   - 大きな文字とアイコン
   - 直感的な操作性

3. **家族共有機能**
   - URLを共有するだけで同じタスクリストにアクセス
   - リアルタイムで更新を共有
   - 認証不要ですぐに使える

### 📝 技術的な決定事項

1. **Freezedの使用を見送り**
   - 初期段階では複雑性を避けるため、シンプルなモデルクラスを使用
   - 後で必要に応じて導入可能

2. **ディレクトリ構造**
   ```
   lib/
   ├── features/       # 機能別モジュール
   ├── core/          # 共通機能
   ├── shared/        # 共有リソース
   └── data/          # JSONデータファイル（NEW!）
   ```

3. **データ構造の設計**
   - 手続きごとに難易度要因を含む詳細情報
   - 依存関係と時系列を考慮
   - 感情的側面への配慮

### 🚀 次のステップ

1. **本番環境デプロイ**
   - Supabaseプロジェクトへのデータ投入
   - Flutter Webのビルドとホスティング
   - カスタムドメインの設定

2. **機能拡張**
   - メモ機能の強化
   - 写真アップロード機能
   - 期限リマインダー
   - 印刷機能

3. **UI/UX改善**
   - ダークモード対応
   - より詳細な進捗表示
   - タスクのフィルタリング・検索

4. **ネイティブアプリ対応**
   - iOS/Androidアプリとしてリリース
   - プッシュ通知機能
   - オフライン対応の強化

### 💡 学んだこと

- **コア機能は「網羅性」**：やることが多すぎて困っている人に、体系的な手続きリストを提供
- **難易度の可視化が重要**：対面/電話/オンラインの違いは手続きの負担に直結
- **実体験の価値**：記事から抽出した「同意書50枚」「印鑑のヒント」などのリアルな情報
- **感情的側面への配慮**：各手続きの精神的負担を認識し、サポート情報を提供

### 🔧 開発環境

- Flutter: 3.32.4
- Dart: SDK付属
- 開発マシン: macOS
- ブラウザ: Safari（web-serverモードで起動）

### 📊 データ統計

- 抽出した手続き数: 56件
- カバーするライフステージ: 9つ
- カテゴリ: 5種類（準備、手続き、連絡調整、情報収集、金銭管理）
- 優先度: 3段階（高、中、低）

### 📌 メモ

- アプリ起動コマンド: `flutter run -d web-server --web-port 8080`
- Supabase環境変数は`.env`ファイルで管理
- GitHubリポジトリ: https://github.com/DELAxGithub/michishirebe.git
- 主要ファイル:
  - `supabase_schema.sql`: データベーススキーマ
  - `seed_procedures.sql`: 56件の手続きデータ
  - `michishirube-tasks-csv.txt`: CSVマスターデータ

### 🔑 Supabaseセットアップ手順

1. Supabaseダッシュボードでプロジェクト作成
2. SQLエディタで以下を実行:
   - `supabase_schema.sql`でテーブル作成
   - `seed_procedures.sql`でデータ投入
3. `.env`ファイルに接続情報を設定:
   ```
   SUPABASE_URL=your_project_url
   SUPABASE_ANON_KEY=your_anon_key
   ```
4. アプリを起動して動作確認