import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_testing/utils/supabase_wrapper/supabase_wrapper.dart';

abstract class _AuthRepository {
  const _AuthRepository();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });
}

class AuthReposImpl extends _AuthRepository {
  final Ref ref;
  const AuthReposImpl(this.ref);

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final supabase = ref.read(supabaseClientProvider);

      await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final supabase = ref.read(supabaseClientProvider);

      await supabase.auth.signUp(password: password, email: email);
    } catch (e) {
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<_AuthRepository>((ref) {
  return AuthReposImpl(ref);
});
