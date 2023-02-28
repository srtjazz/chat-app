import 'dart:io';
import 'package:chat/core/services/auth/auth_firebase_service.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';

import '../../models/chat_user.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    //return AuthMockService();
    return AuthFirebaseService();
  }
}
