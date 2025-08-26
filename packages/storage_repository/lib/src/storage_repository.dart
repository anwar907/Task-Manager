abstract class StorageRepository<T> {
  Future<U?> read<U>(String key);
  Future<bool> delete(String key);
  Future<void> clear();
  Future<void> save(String key, T value);
}
