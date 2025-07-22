# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is the Michi-shirube (みちしるべ) app repository - an end-of-life planning and family coordination app that helps families navigate the complex processes of eldercare, medical decisions, and inheritance procedures.

## Project Context

Based on real experiences documented in the article "両親の入院と介護と看取りと相続についてまとめておく", this app aims to:
- Organize complex procedures into manageable steps
- Enable family collaboration and task sharing
- Reduce emotional and mental burden during difficult times

## Technology Stack

- **Frontend**: Flutter/Dart
- **Backend**: Supabase (Auth, Database, Real-time, Storage)
- **State Management**: Riverpod
- **Platform**: iOS, Android, Web

## Common Development Tasks

### Flutter Development Commands

```bash
# Development
flutter run
flutter run --dart-define=SUPABASE_URL=xxx --dart-define=SUPABASE_ANON_KEY=xxx

# Building
flutter clean
flutter pub get
flutter build ios --release
flutter build apk --release
flutter build web

# Testing
flutter test
flutter test --coverage

# Code generation (if using freezed/json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Supabase Local Development

```bash
# Start Supabase locally
supabase start

# Stop Supabase
supabase stop

# Reset local database
supabase db reset

# Generate types
supabase gen types typescript --local > lib/types/database.types.ts
```

## Project Structure

```
michishirube/
├── lib/
│   ├── main.dart
│   ├── features/
│   │   ├── auth/
│   │   ├── tasks/
│   │   ├── family/
│   │   └── documents/
│   ├── core/
│   │   ├── providers/
│   │   ├── router/
│   │   └── theme/
│   └── shared/
│       ├── widgets/
│       └── utils/
├── test/
├── ios/
├── android/
└── web/
```

## Key Features

### MVP Features
1. **Step-based Task Management**: 5 main life stages with predefined tasks
2. **Family Sharing**: Real-time collaboration with URL sharing
3. **Document Storage**: Secure storage for important documents
4. **Contact Management**: Centralized contact list for care providers

### Database Schema

```sql
-- Users and Families
profiles (id, email, name, created_at)
families (id, name, created_at, invite_code)
family_members (family_id, user_id, role, joined_at)

-- Tasks and Steps
steps (id, name, order, description)
tasks (id, step_id, family_id, title, description, due_date, status, assigned_to)
task_templates (id, step_id, title, description, order)

-- Documents and Contacts
documents (id, family_id, name, type, url, uploaded_by)
contacts (id, family_id, name, role, phone, email, notes)
```

## Development Principles

1. **Accessibility First**: Large fonts, clear UI for elderly users
2. **Offline Support**: Critical features work without internet
3. **Security**: End-to-end encryption for sensitive documents
4. **Simplicity**: Minimal steps to accomplish tasks
5. **Cultural Sensitivity**: Respect for Japanese customs and procedures

## Testing Approach

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for critical user flows
- Manual testing with elderly users

## Deployment

### iOS
1. Update version in pubspec.yaml
2. Build with `flutter build ios --release`
3. Archive in Xcode and upload to TestFlight

### Android
1. Build with `flutter build appbundle`
2. Upload to Google Play Console

### Web
1. Build with `flutter build web`
2. Deploy to hosting service (Vercel/Netlify)

## Important Notes

- All UI text should be in Japanese
- Follow Japanese date/time formats
- Consider users with limited tech experience
- Prioritize data privacy and security
- Test on older devices

## Common Issues and Solutions

### Supabase Connection Issues
- Check environment variables
- Verify Supabase project status
- Check network connectivity

### Flutter Build Issues
- Run `flutter clean`
- Delete `ios/Pods` and run `pod install`
- Check Flutter/Dart SDK versions

### State Management
- Use Riverpod providers consistently
- Implement proper error handling
- Cache data appropriately

## References

- [Original article](両親の入院と介護と看取りと相続についてまとめておく｜akita11.md)
- [StepBaby inspiration](【StepBaby】妊娠・出産・育児のやるべきことリストを管理できるアプリを作りました！｜トマトミントSWC.md)
- [App concept document](終活・相続手続きナビゲーター.md)


description: "spec-driven development"
---

Claude Codeを用いたspec-driven developmentを行います。

## spec-driven development とは

spec-driven development は、以下の5つのフェーズからなる開発手法です。

### 1. 事前準備フェーズ

- ユーザーがClaude Codeに対して、実行したいタスクの概要を伝える
- このフェーズで !`mkdir -p ./.cckiro/specs`  を実行します
- `./cckiro/specs` 内にタスクの概要から適切な spec 名を考えて、その名前のディレクトリを作成します
    - たとえば、「記事コンポーネントを作成する」というタスクなら `./cckiro/specs/create-article-component` という名前のディレクトリを作成します
- 以下ファイルを作成するときはこのディレクトリの中に作成します

### 2. 要件フェーズ

- Claude Codeがユーザーから伝えられたタスクの概要に基づいて、タスクが満たすべき「要件ファイル」を作成する
- Claude Codeがユーザーに対して「要件ファイル」を提示し、問題がないかを尋ねる
- ユーザーが「要件ファイル」を確認し、問題があればClaude Codeに対してフィードバックする
- ユーザーが「要件ファイル」を確認し、問題がないと答えるまで「要件ファイル」に対して修正を繰り返す

### 3. 設計フェーズ

- Claude Codeは、「要件ファイル」に記載されている要件を満たすような設計を記述した「設計ファイル」を作成する
- Claude Codeがユーザーに対して「設計ファイル」を提示し、問題がないかを尋ねる
- ユーザーが「設計ファイル」を確認し、問題があればClaude Codeに対してフィードバックする
- ユーザーが「設計ファイル」を確認し、問題がないと答えるまで「要件ファイル」に対して修正を繰り返す

### 4. 実装計画フェーズ

- Claude Codeは、「設計ファイル」に記載されている設計を実装するための「実装計画ファイル」を作成する
- Claude Codeがユーザーに対して「実装計画ファイル」を提示し、問題がないかを尋ねる
- ユーザーが「実装計画ファイル」を確認し、問題があればClaude Codeに対してフィードバックする
- ユーザーが「実装計画ファイル」を確認し、問題がないと答えるまで「要件ファイル」に対して修正を繰り返す

### 5. 実装フェーズ

- Claude Codeは、「実装計画ファイル」に基づいて実装を開始する
- 実装するときは「要件ファイル」「設計ファイル」に記載されている内容を守りながら実装してください


https://github.com/DELAxGithub/michishirebe.git

