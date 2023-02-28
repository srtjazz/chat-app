import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
  }

  //Push Notifications

  Future<void> init() async {
    await _configureTerminatedApplication();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final setings = await messaging.requestPermission();
    return setings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminatedApplication() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMessage);
    }
  }

  void _messageHandler(RemoteMessage? message) {
    if (message == null || message.notification == null) return;
    add(ChatNotification(
      title: message.notification!.title ?? 'Não informado',
      body: message.notification!.body ?? 'Não informado',
    ));
  }
}
