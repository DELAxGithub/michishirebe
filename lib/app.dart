import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/session_service.dart';
import 'core/providers/session_provider.dart';

class MichishirubeApp extends ConsumerStatefulWidget {
  const MichishirubeApp({super.key});

  @override
  ConsumerState<MichishirubeApp> createState() => _MichishirubeAppState();
}

class _MichishirubeAppState extends ConsumerState<MichishirubeApp> {
  @override
  void initState() {
    super.initState();
    // URLパラメータからセッションIDを取得
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUrlParameters();
    });
  }

  Future<void> _checkUrlParameters() async {
    // Web環境でのみ実行
    if (!kIsWeb) return;
    
    final currentUrl = Uri.base.toString();
    final sessionId = SessionService.extractSessionIdFromUrl(currentUrl);
    
    if (sessionId != null) {
      // URLパラメータからセッションIDを取得した場合は保存
      await SessionService.setSessionId(sessionId);
      // プロバイダーを更新
      ref.invalidate(sessionIdProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'みちしるべ',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}