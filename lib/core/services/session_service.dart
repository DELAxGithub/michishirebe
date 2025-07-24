import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SessionService {
  static const String _sessionKey = 'michi_session_id';
  
  // セッションIDを取得（なければ生成）
  static Future<String> getOrCreateSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 既存のセッションIDを取得
    String? sessionId = prefs.getString(_sessionKey);
    
    // なければ新規生成
    if (sessionId == null) {
      sessionId = _generateSessionId();
      await prefs.setString(_sessionKey, sessionId);
    }
    
    return sessionId;
  }
  
  // 現在のセッションIDを取得（生成はしない）
  static Future<String?> getCurrentSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionKey);
  }
  
  // セッションIDを設定（URLパラメータから受け取った場合など）
  static Future<void> setSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, sessionId);
  }
  
  // セッションをクリア
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
  
  // セッションIDを生成
  static String _generateSessionId() {
    final random = Random.secure();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const length = 16;
    
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }
  
  // 共有用URLを生成
  static String generateShareUrl(String sessionId) {
    // TODO: 本番環境では適切なドメインに変更
    const baseUrl = 'http://localhost:8080';
    return '$baseUrl?session=$sessionId';
  }
  
  // URLパラメータからセッションIDを抽出
  static String? extractSessionIdFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    
    return uri.queryParameters['session'];
  }
}