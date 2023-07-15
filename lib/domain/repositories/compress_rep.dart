abstract class CompressRepository {
  Future<bool> compress(
    String path, {
    void Function(double progress)? listen,
    void Function(String path)? onSuccess,
    void Function(String message)? onFailure,
  });
}
