import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 環境変数を読み込む
  await dotenv.load(fileName: ".env");
  
  // Supabaseの初期化
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  
  if (supabaseUrl != null && supabaseAnonKey != null) {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  } else {
    // 環境変数が設定されていない場合はモックモードで起動
    debugPrint('警告: Supabase環境変数が設定されていません。モックモードで起動します。');
  }

  runApp(
    const ProviderScope(
      child: MichishirubeApp(),
    ),
  );
}