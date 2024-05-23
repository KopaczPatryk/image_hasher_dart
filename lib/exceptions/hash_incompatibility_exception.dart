class HashIncompatibilityException implements Exception {
  final String message;

  const HashIncompatibilityException({
    required this.message,
  });
}
