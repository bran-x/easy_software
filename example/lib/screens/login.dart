import 'package:easy_software/easy_software.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPageExample extends StatelessWidget {
  const LoginPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage(
      title: 'Titulo del Login',
      backgroundButtonColor: Colors.deepPurple,
      contentFlex: 1,
      onLogin: (username, password) {
        if (kDebugMode) {
          print('Username: $username');
        }
        if (kDebugMode) {
          print('Password: $password');
        }
      },
    );
  }
}
