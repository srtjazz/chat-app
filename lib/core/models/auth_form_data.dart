// ignore_for_file: constant_identifier_names, prefer_final_fields

import 'dart:io';

enum AuthMode { SignUp, Login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSignup {
    return _mode == AuthMode.SignUp;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.SignUp : AuthMode.Login;
  }
}
