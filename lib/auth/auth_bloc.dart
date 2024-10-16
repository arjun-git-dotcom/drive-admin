import 'package:drive_admin_bloc/auth/auth_event.dart';
import 'package:drive_admin_bloc/auth/auth_state.dart';
import 'package:drive_admin_bloc/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authservices authservices;

  AuthBloc({required this.authservices}) : super(Authinitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());

      final token = await authservices.login(event.email, event.password);

      if (token != null) {
        emit(Authauthenticated());
      } else {
        emit(AuthError(message: 'invalid login'));
      }
    });
    on<AuthLogoutRequested>((event, emit) {
      emit(Unauthenticated());
    });

    on<CheckLogin>((event, emit) async {
      emit(AuthLoading());

      try {
        final isAuthenticated = await authservices.isLoggedIn();

        if (isAuthenticated) {
          emit(Authauthenticated());
        } else {
          emit(Unauthenticated());
        }
      } catch (error) {
        emit(Unauthenticated());
      }
    });
  }
}
