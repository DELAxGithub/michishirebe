# みちしるべ (Michi-shirube)

高齢の親を持つ家族のための、入院・介護・看取り・相続の手続きを管理するWebアプリケーション。

## 概要

「みちしるべ」は、複雑な手続きを視覚化し、家族で共有できるTodoリストに変換することで、精神的・時間的負担を軽減するアプリです。

## 主な機能

- **手続きの視覚化**: 5つのライフステージ（入院準備・介護申請・施設選び・看取り準備・相続手続き）に整理された手続きリスト
- **ドメイン知識の提供**: 各手続きの説明、必要書類、注意点などの情報提供
- **Todo管理**: 手続きをタスク化し、進捗管理
- **家族共有**: URLによる簡単な家族間共有

## 技術スタック

- **Frontend**: Flutter Web
- **Backend**: Supabase
- **State Management**: Riverpod
- **Router**: go_router

## 開発環境のセットアップ

### 必要な環境

- Flutter 3.0以上
- Dart 3.0以上

### インストール手順

1. リポジトリをクローン
```bash
git clone https://github.com/DELAxGithub/michishirebe.git
cd michishirebe
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. コード生成
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. 環境変数の設定（Supabase準備後）
```bash
flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

## 開発

### アプリの実行
```bash
flutter run -d chrome
```

### コード生成（モデルやProviderの変更時）
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### テスト
```bash
flutter test
```

## プロジェクト構造

```
lib/
├── main.dart              # エントリーポイント
├── app.dart               # アプリケーション設定
├── features/              # 機能別モジュール
│   ├── auth/             # 認証機能
│   ├── procedures/       # 手続き視覚化
│   ├── tasks/           # Todo管理
│   └── family/          # 家族共有
├── core/                 # コア機能
│   ├── router/          # ルーティング
│   ├── theme/           # テーマ設定
│   └── providers/       # グローバルProvider
└── shared/              # 共通リソース
    ├── widgets/         # 共通ウィジェット
    └── utils/           # ユーティリティ
```

## ライセンス

[ライセンスを追加予定]