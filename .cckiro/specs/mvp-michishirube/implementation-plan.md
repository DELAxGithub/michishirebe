# みちしるべアプリ MVP実装計画書

## 1. 実装タスク一覧

### Phase 1: 基盤構築（Day 1-5）

#### 1.1 プロジェクトセットアップ
- [ ] Flutterプロジェクト作成
- [ ] 必要なパッケージ追加（supabase_flutter, riverpod, go_router等）
- [ ] ディレクトリ構造の作成
- [ ] 基本的なテーマ設定（カラー、フォント）

#### 1.2 Supabase設定
- [ ] Supabaseプロジェクト作成
- [ ] データベーススキーマ作成
- [ ] RLS（Row Level Security）ポリシー設定
- [ ] 初期データ（手続きテンプレート）投入

#### 1.3 認証機能
- [ ] ログイン画面UI作成
- [ ] 新規登録画面UI作成
- [ ] Supabase認証の実装
- [ ] 認証状態管理（Riverpod）

#### 1.4 ルーティング設定
- [ ] go_routerの基本設定
- [ ] 認証ガード実装
- [ ] 画面遷移の定義

### Phase 2: コア機能実装（Day 6-15）

#### 2.1 手続き視覚化機能
- [ ] ライフステージ一覧画面
- [ ] 手続き詳細画面
- [ ] 手続きデータのProvider作成
- [ ] 進捗表示機能

#### 2.2 Todo管理機能
- [ ] タスク一覧画面
- [ ] タスク追加機能（手続きから変換）
- [ ] タスク編集・削除機能
- [ ] ステータス更新機能

#### 2.3 データ同期
- [ ] Supabase Realtimeの設定
- [ ] タスク更新の同期実装
- [ ] 楽観的更新の実装

#### 2.4 家族管理機能
- [ ] 家族作成機能
- [ ] 招待コード生成
- [ ] 家族参加機能
- [ ] メンバー一覧表示

### Phase 3: 仕上げ（Day 16-21）

#### 3.1 UI/UXブラッシュアップ
- [ ] レスポンシブ対応
- [ ] ローディング表示
- [ ] エラーハンドリング
- [ ] 空状態の表示

#### 3.2 品質向上
- [ ] 基本的なテスト作成
- [ ] パフォーマンス最適化
- [ ] アクセシビリティ対応

#### 3.3 デプロイ準備
- [ ] 環境変数の整理
- [ ] ビルド設定
- [ ] デプロイ手順書作成

## 2. 実装の詳細手順

### 2.1 Day 1: プロジェクト初期化

```bash
# Flutterプロジェクト作成
flutter create michishirube --org jp.michishirube --platforms web

# ディレクトリ移動
cd michishirube

# パッケージ追加
flutter pub add supabase_flutter
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add go_router
flutter pub add google_fonts

# 開発用パッケージ
flutter pub add --dev build_runner
flutter pub add --dev riverpod_generator
```

### 2.2 Day 2-3: Supabase設定

1. Supabaseダッシュボードでプロジェクト作成
2. SQLエディタでスキーマ作成
3. 環境変数設定
4. RLSポリシー実装

### 2.3 Day 4-5: 認証実装

```dart
// 認証Provider
final authStateProvider = StreamProvider<User?>((ref) {
  return supabase.auth.authStateChanges;
});

// ログイン機能
Future<void> signIn(String email, String password) async {
  await supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
}
```

### 2.4 Day 6-10: 手続き機能

1. 手続きデータの構造化
2. UIコンポーネント作成
3. Provider実装
4. 画面実装

### 2.5 Day 11-15: Todo機能

1. タスクモデル定義
2. CRUD操作実装
3. リアルタイム同期
4. UI実装

### 2.6 Day 16-21: 仕上げ

1. 全体的なUI調整
2. エラーハンドリング追加
3. テスト実施
4. デプロイ

## 3. 技術的な実装ポイント

### 3.1 状態管理パターン
```dart
// Freezedを使用したモデル定義
@freezed
class Task with _$Task {
  factory Task({
    required String id,
    required String title,
    required TaskStatus status,
    // ...
  }) = _Task;
}

// Riverpodでの状態管理
@riverpod
class TaskList extends _$TaskList {
  Future<List<Task>> build(String familyId) async {
    // Supabaseからデータ取得
  }
}
```

### 3.2 リアルタイム同期
```dart
// Supabase Realtimeの設定
final taskStreamProvider = StreamProvider.family<List<Task>, String>((ref, familyId) {
  return supabase
    .from('tasks')
    .stream(primaryKey: ['id'])
    .eq('family_id', familyId)
    .map((data) => data.map((json) => Task.fromJson(json)).toList());
});
```

### 3.3 エラーハンドリング
```dart
// グローバルエラーハンドラー
class ErrorHandler {
  static void handleError(Object error, StackTrace stackTrace) {
    // エラーログ記録
    // ユーザーへの通知
  }
}
```

## 4. リスクと対策

### 4.1 技術的リスク
- **リスク**: Supabaseの無料枠制限
- **対策**: 使用量モニタリング、効率的なクエリ

### 4.2 スケジュールリスク
- **リスク**: 予期せぬ技術的課題
- **対策**: バッファ時間の確保、機能の優先順位付け

### 4.3 品質リスク
- **リスク**: 高齢者向けUIの検証不足
- **対策**: 早期のユーザーテスト実施

## 5. 完了基準

### 5.1 機能要件
- [ ] 5つのライフステージが表示できる
- [ ] 手続きをTodoに変換できる
- [ ] 家族でTodoを共有できる
- [ ] リアルタイムで同期される

### 5.2 非機能要件
- [ ] 文字サイズ18px以上
- [ ] 3秒以内の初回読み込み
- [ ] レスポンシブ対応
- [ ] 基本的なエラーハンドリング

## 6. 次のステップ

実装開始前の確認事項：
1. Supabaseアカウントの準備
2. 開発環境の確認
3. この計画の承認

承認後、Phase 1から順次実装を開始します。