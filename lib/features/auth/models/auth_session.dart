class AuthSession {
  final String token;
  final String? refreshToken;
  final bool isVerified;

  const AuthSession({
    required this.token,
    this.refreshToken,
    required this.isVerified,
  });
}
