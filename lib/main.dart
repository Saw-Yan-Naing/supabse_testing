import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_testing/constants/secure_storage_constants.dart';

import 'features/auth/presentation/login.dart';
import 'utils/secure_storage.dart';
import 'utils/supabase_wrapper/supabase_wrapper.dart';

final navigationKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MainApp()));
}

void _initialize(WidgetRef ref) async {
  await ref
      .read(secureStorageProvider)
      .write(
        SecureStorageConstants.anonKey,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNpZWllYXNtdnR4Z3VqZnd3YWZzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg3Njk3NjUsImV4cCI6MjA1NDM0NTc2NX0.iB89QVW3t1Xpp3y9nLiwtaqfrF5W_xW_MtRu7H0aC1U",
      );

  await ref
      .read(secureStorageProvider)
      .write(
        SecureStorageConstants.projectUrl,
        "https://sieieasmvtxgujfwwafs.supabase.co",
      );
   ref.read(supabaseWrapperProvider).initialize();
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      home: const Material(child: LoginScreen()),
    );
  }
}
