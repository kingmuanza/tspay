class AuthException implements Exception {
  final String cause;
  AuthException(this.cause);

  String getMessage() {
    return cause;
  }

  @override
  String toString() {
    return cause;
  }
}
