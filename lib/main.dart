import 'package:drive_admin_bloc/auth/auth_bloc.dart';
import 'package:drive_admin_bloc/auth/auth_event.dart';

import 'package:drive_admin_bloc/auth/auth_state.dart';
import 'package:drive_admin_bloc/auth_services.dart';
import 'package:drive_admin_bloc/authscreen.dart';
import 'package:drive_admin_bloc/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? token;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(authservices: Authservices())..add(CheckLogin()),
        child: BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, state) {
          if (state is AuthLoading) {
            debugPrint(token);
            return const Center(child: CircularProgressIndicator());
          } else if (state is Authauthenticated) {
            return const Homescreen();
          } else if (state is Unauthenticated) {
            return const AuthenticationScreen();
          }
          return const AuthenticationScreen();
        }),
      ),
    );
  }
}
