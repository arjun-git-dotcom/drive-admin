abstract class AuthState {}

class Authinitial extends AuthState {}

class Authauthenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
