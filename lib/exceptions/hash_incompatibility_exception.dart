/// Thrown when two Image hashes are not compatible
class HashIncompatibilityException implements Exception {
  final String message;

  const HashIncompatibilityException({
    required this.message,
  });
}
