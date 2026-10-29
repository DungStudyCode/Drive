import '../models/auth_session.dart';
import '../models/auth_user.dart';

/// Shared contract for mock authentication and the development API.
abstract class AuthRepository {
  /// Returns a temporary session for OTP verification, without persisting it.
  Future<AuthSession> register({
    required String name,
    required String phoneNumber,
    required String password,
  });

  /// Returns a session whose verification status determines the next screen.
  Future<AuthSession> login({
    required String phoneNumber,
    required String password,
  });

  /// Verifies OTP using the temporary session and returns a verified session.
  Future<AuthSession> verifyOtp({
    required AuthSession pendingSession,
    required String code,
  });

  /// Requests another OTP using the temporary session token.
  Future<void> resendOtp({required AuthSession pendingSession});

  /// Fetches the user associated with the current verified session.
  Future<AuthUser> getCurrentUser();

  /// Persists a verified session securely; rejects unverified sessions.
  Future<void> saveSession(AuthSession session);

  /// Restores and validates a saved session.
  /// Returns null for a missing or invalid session; network errors are thrown.
  Future<AuthSession?> restoreSession();

  /// Signs out and clears local session data, including on remote failure.
  Future<void> logout();
}
