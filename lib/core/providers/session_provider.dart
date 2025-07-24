import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/session_service.dart';

// セッションIDプロバイダー
final sessionIdProvider = FutureProvider<String>((ref) async {
  return await SessionService.getOrCreateSessionId();
});

// 現在のセッションIDプロバイダー（nullable）
final currentSessionIdProvider = FutureProvider<String?>((ref) async {
  return await SessionService.getCurrentSessionId();
});