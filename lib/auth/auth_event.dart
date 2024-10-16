abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  // final String username;
  final String password;
  final String email;

  AuthLoginRequested({required this.email, required this.password});
  
}

class AuthLogoutRequested extends AuthEvent{}

class CheckLogin extends AuthEvent{}
