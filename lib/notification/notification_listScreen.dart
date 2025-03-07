import 'package:e_stocker/screens/main_screens/sub_screens.dart/ordersummary.dart';
import 'package:flutter/material.dart';

class NotificationListScreen extends StatefulWidget {
  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
      ),
      body: notificationService.notifications.isEmpty
          ? Center(child: Text("No Notifications"))
          : ListView.builder(
              itemCount: notificationService.notifications.length,
              itemBuilder: (context, index) {
                var notification = notificationService.notifications[index];
                return ListTile(
                  title: Text(notification['title']!),
                  subtitle: Text(notification['body']!),
                  leading: Icon(Icons.notifications_active, color: Colors.blue),
                );
              },
            ),
    );
  }
}
