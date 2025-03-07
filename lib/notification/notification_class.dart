import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationClass {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  final List<Map<String, String>> _notifications = [];

  List<Map<String, String>> get notifications => _notifications;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    await notificationPlugin.initialize(initSettings);

    await requestPermissions();

    _isInitialized = true;
  }

  Future<void> requestPermissions() async {
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'low_stock_channel',
        'Low Stock Alerts',
        channelDescription: 'Notifies when stock is low',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );
  }

  Future<void> showNotification(
      {int id = 0, required String title, required String body}) async {
    await notificationPlugin.show(id, title, body, notificationDetails());

    // 🔹 Store the notification
    _notifications.add({'title': title, 'body': body});
  }

  // Clear all stored notifications
  void clearNotifications() {
    _notifications.clear();
  }
}
