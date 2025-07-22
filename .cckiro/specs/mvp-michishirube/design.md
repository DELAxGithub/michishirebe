# みちしるべアプリ MVP設計書

## 1. アーキテクチャ概要

### 1.1 技術スタック
- **フロントエンド**: Flutter Web
- **バックエンド**: Supabase
  - Authentication: メール認証
  - Database: PostgreSQL
  - Realtime: WebSocket経由の同期
- **状態管理**: Riverpod
- **ルーティング**: go_router

### 1.2 アプリケーション構造
```
lib/
├── main.dart
├── app.dart
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   ├── application/
│   │   └── data/
│   ├── procedures/        # 手続き視覚化
│   │   ├── presentation/
│   │   ├── application/
│   │   └── domain/
│   ├── tasks/            # Todo管理
│   │   ├── presentation/
│   │   ├── application/
│   │   └── data/
│   └── family/           # 家族共有
│       ├── presentation/
│       ├── application/
│       └── data/
├── core/
│   ├── router/
│   ├── theme/
│   └── providers/
└── shared/
    ├── widgets/
    └── utils/
```

## 2. データモデル設計

### 2.1 データベーススキーマ

```sql
-- ユーザー管理
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  email TEXT NOT NULL,
  name TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 家族グループ
CREATE TABLE families (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  invite_code TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_by UUID REFERENCES profiles(id)
);

-- 家族メンバー
CREATE TABLE family_members (
  family_id UUID REFERENCES families(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  role TEXT DEFAULT 'member', -- 'admin' or 'member'
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (family_id, user_id)
);

-- ライフステージ（マスターデータ）
CREATE TABLE life_stages (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  order_index INTEGER NOT NULL,
  icon_name TEXT
);

-- 手続きテンプレート（マスターデータ）
CREATE TABLE procedure_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  life_stage_id INTEGER REFERENCES life_stages(id),
  title TEXT NOT NULL,
  description TEXT,
  required_documents TEXT[],
  deadline_info TEXT,
  tips TEXT,
  order_index INTEGER NOT NULL,
  dependencies UUID[] -- 他の手続きへの依存関係
);

-- タスク
CREATE TABLE tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  family_id UUID REFERENCES families(id) ON DELETE CASCADE,
  procedure_template_id UUID REFERENCES procedure_templates(id),
  title TEXT NOT NULL,
  description TEXT,
  status TEXT DEFAULT 'pending', -- 'pending', 'in_progress', 'completed'
  assigned_to UUID REFERENCES profiles(id),
  due_date DATE,
  completed_at TIMESTAMP WITH TIME ZONE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_by UUID REFERENCES profiles(id),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Row Level Security
ALTER TABLE families ENABLE ROW LEVEL SECURITY;
ALTER TABLE family_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
```

### 2.2 初期データ（手続きテンプレート）

```yaml
life_stages:
  - id: 1
    name: "入院準備"
    icon: "hospital"
    procedures:
      - "入院手続き・同意書の準備"
      - "医療保険の確認・申請準備"
      - "入院用品の準備"
      - "家族への連絡体制構築"
      
  - id: 2
    name: "介護申請"
    icon: "care"
    procedures:
      - "要介護認定の申請"
      - "ケアマネージャーの選定"
      - "介護サービスの検討"
      - "介護保険証の受領"
      
  - id: 3
    name: "施設選び"
    icon: "home"
    procedures:
      - "施設の種類を理解する"
      - "候補施設のリストアップ"
      - "施設見学の予約・実施"
      - "入居申込・契約"
      
  - id: 4
    name: "看取り準備"
    icon: "heart"
    procedures:
      - "延命治療の意思確認"
      - "葬儀社の選定・事前相談"
      - "エンディングノートの作成"
      - "遺言書の作成支援"
      
  - id: 5
    name: "相続手続き"
    icon: "document"
    procedures:
      - "死亡届の提出"
      - "年金・保険の停止手続き"
      - "相続人の確定・戸籍収集"
      - "遺産分割協議・相続登記"
```

## 3. 画面設計

### 3.1 画面構成
1. **ランディングページ** - サービス説明
2. **ログイン/新規登録**
3. **ダッシュボード** - 進捗概要
4. **手続き一覧** - 5つのステージ表示
5. **手続き詳細** - 各手続きの説明とTodo化
6. **タスク一覧** - 家族のTodo管理
7. **家族管理** - メンバー招待・管理

### 3.2 主要画面の詳細

#### 3.2.1 手続き一覧画面
```
┌─────────────────────────────────┐
│  みちしるべ                [ログアウト] │
├─────────────────────────────────┤
│                                 │
│  現在の進捗: 入院準備 (4/12完了)    │
│                                 │
│  ┌──────────┐ ┌──────────┐      │
│  │ 1.入院準備 │ │ 2.介護申請 │      │
│  │   ■■□□   │ │   □□□□   │      │
│  └──────────┘ └──────────┘      │
│                                 │
│  ┌──────────┐ ┌──────────┐      │
│  │ 3.施設選び │ │ 4.看取り準備│      │
│  │   □□□□   │ │   □□□□   │      │
│  └──────────┘ └──────────┘      │
│                                 │
│  ┌──────────┐                  │
│  │ 5.相続手続 │                  │
│  │   □□□□   │                  │
│  └──────────┘                  │
└─────────────────────────────────┘
```

#### 3.2.2 手続き詳細画面
```
┌─────────────────────────────────┐
│ ← 入院準備                        │
├─────────────────────────────────┤
│                                 │
│ 入院手続き・同意書の準備            │
│                                 │
│ 説明:                            │
│ 入院時には多くの書類への記入が      │
│ 必要です。事前に準備しておくと      │
│ スムーズです。                    │
│                                 │
│ 必要書類:                        │
│ ・健康保険証                     │
│ ・診察券                         │
│ ・印鑑                          │
│                                 │
│ ポイント:                        │
│ 同じ内容を何度も書くことになる     │
│ ので、メモを用意しておくと便利     │
│                                 │
│ [Todoリストに追加]               │
└─────────────────────────────────┘
```

## 4. API設計

### 4.1 Supabase Functions（必要最小限）
- 基本的にはSupabaseのAuto-generated APIを使用
- カスタム関数は以下のみ：
  - `generate_invite_code()`: 招待コード生成
  - `join_family(invite_code)`: 家族参加

### 4.2 Realtime Subscriptions
```dart
// タスク更新の監視
supabase
  .from('tasks')
  .stream(primaryKey: ['id'])
  .eq('family_id', familyId)
  .listen((payload) {
    // UIを更新
  });
```

## 5. セキュリティ設計

### 5.1 Row Level Security (RLS)
- ユーザーは所属する家族のデータのみアクセス可能
- タスクの作成・更新は家族メンバーのみ
- 家族の管理者のみメンバー削除可能

### 5.2 認証フロー
1. メールアドレスでサインアップ
2. 確認メール送信
3. メールリンククリックで認証完了
4. プロフィール作成 → 家族作成or参加

## 6. UI/UXガイドライン

### 6.1 デザイン原則
- **視認性**: 大きな文字、明確なコントラスト
- **簡潔性**: 必要最小限の情報表示
- **一貫性**: 統一された操作方法
- **安心感**: 落ち着いた色調、丁寧な説明

### 6.2 カラーパレット
```dart
primary: Color(0xFF2E7D32),    // 落ち着いた緑
secondary: Color(0xFF1976D2),  // 信頼感のある青
background: Color(0xFFFAFAFA), // オフホワイト
text: Color(0xFF212121),       // ほぼ黒
error: Color(0xFFD32F2F),      // 警告赤
```

### 6.3 タイポグラフィ
- 本文: 18px (最小16px)
- 見出し: 24px〜32px
- フォント: Noto Sans JP

## 7. 開発の優先順位

### Phase 1: 基盤構築（1週目）
1. Flutterプロジェクトセットアップ
2. Supabase連携
3. 認証機能実装
4. 基本的なルーティング

### Phase 2: コア機能（2週目）
1. 手続きデータの表示
2. Todo変換機能
3. タスク管理CRUD
4. リアルタイム同期

### Phase 3: 仕上げ（3週目）
1. 家族招待機能
2. UI/UXブラッシュアップ
3. エラーハンドリング
4. デプロイ準備