import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageRef = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

class _SecureStorage {
  final Ref ref;

  const _SecureStorage(this.ref);

  Future<void> write(String key, String value) async {
    final storage = ref.watch(storageRef);
    await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    final storage = ref.watch(storageRef);
    return await storage.read(key: key);
  }

  Future<void> delete(String key) async {
    final storage = ref.watch(storageRef);
    await storage.delete(key: key);
  }
}

final secureStorageProvider = Provider<_SecureStorage>((ref) {
  return _SecureStorage(ref);
});
