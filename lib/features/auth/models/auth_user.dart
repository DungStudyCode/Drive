class AuthUser {
  final String id;
  final String name;
  final String phoneNumber;
  final bool isVerified;

  const AuthUser({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.isVerified,
  });
}
