# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Michi-shirube (みちしるべ) - An end-of-life planning and family coordination app built with Flutter and Supabase. The app helps families navigate eldercare, medical decisions, and inheritance procedures through organized task management and collaboration.

## Technology Stack

- **Frontend**: Flutter/Dart (cross-platform mobile and web)
- **Backend**: Supabase (authentication, database, real-time features, storage)
- **State Management**: Riverpod
- **Platforms**: iOS, Android, Web

## Common Development Commands

### Initial Setup (if project not initialized)
```bash
flutter create michishirebe --org com.example --platforms ios,android,web
cd michishirebe
flutter pub add supabase_flutter riverpod flutter_riverpod
```

### Development
```bash
# Run with environment variables
flutter run --dart-define=SUPABASE_URL=xxx --dart-define=SUPABASE_ANON_KEY=xxx

# Run on specific platform
flutter run -d chrome  # Web
flutter run -d ios     # iOS simulator
```

### Build & Test
```bash
# Build commands
flutter build ios --release
flutter build apk --release
flutter build web

# Testing
flutter test
flutter test --coverage

# Linting
flutter analyze
```

### Supabase Local Development
```bash
supabase start           # Start local instance
supabase db reset        # Reset database
supabase gen types typescript --local > lib/types/database.types.ts
```

## Architecture

The app follows a feature-based architecture:

```
lib/
├── main.dart              # Entry point
├── features/              # Feature modules
│   ├── auth/             # Authentication (login, profile management)
│   ├── tasks/            # Task management with 5 life stages
│   ├── family/           # Family sharing and collaboration
│   └── documents/        # Document storage and management
├── core/
│   ├── providers/        # Riverpod providers
│   ├── router/           # Navigation logic
│   └── theme/            # App theming (accessibility-focused)
└── shared/
    ├── widgets/          # Reusable UI components
    └── utils/            # Helper functions
```

## Key Design Decisions

1. **Accessibility First**: All UI elements use large fonts and high contrast for elderly users
2. **Offline Support**: Core features cached locally using Hive/SharedPreferences
3. **Japanese Localization**: All text in Japanese, following cultural conventions
4. **Real-time Collaboration**: Family members see updates instantly via Supabase real-time

## Database Schema (Supabase)

Main tables:
- `profiles`: User information linked to auth.users
- `families`: Family groups with unique invite codes
- `family_members`: Junction table with roles (admin/member)
- `steps`: 5 predefined life stages (入院準備, 介護申請, etc.)
- `tasks`: User-created tasks linked to steps
- `documents`: Secure document storage with family access control
- `contacts`: Shared contact information for care providers

## spec-driven development

This project uses spec-driven development. When implementing new features:

1. **事前準備**: Create spec directory in `./.cckiro/specs/[feature-name]`
2. **要件フェーズ**: Create requirements file detailing what the feature should do
3. **設計フェーズ**: Create design file with technical implementation details
4. **実装計画フェーズ**: Create implementation plan with step-by-step tasks
5. **実装フェーズ**: Execute the plan following requirements and design

## Important Context

- Based on real experiences from "両親の入院と介護と看取りと相続についてまとめておく"
- Target users are families dealing with elderly care in Japan
- Must handle sensitive medical and financial information securely
- UI must be intuitive for users with limited tech experience