import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants/secure_storage_constants.dart';
import '../secure_storage.dart';

class SupabaseWrapper {
  final Ref ref;
  const SupabaseWrapper({required this.ref});

  Future<void> initialize() async {
    final anonKey = await ref
        .read(secureStorageProvider)
        .read(SecureStorageConstants.anonKey);

    final projectUrl = await ref
        .read(secureStorageProvider)
        .read(SecureStorageConstants.projectUrl);

    debugPrint('anonKey: $anonKey');
    debugPrint('projectUrl: $projectUrl');

    if (anonKey != null && projectUrl != null) {
      await Supabase.initialize(url: projectUrl, anonKey: anonKey);
    }
  }
}

final supabaseWrapperProvider = Provider((ref) => SupabaseWrapper(ref: ref));

final supabaseClientProvider = Provider((ref) {
  ref.watch(supabaseWrapperProvider);
  return Supabase.instance.client;
});
