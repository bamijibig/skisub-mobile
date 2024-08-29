import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "Money Transfer",
      "description": "You have successfully credited your wallet ₦1000",
      "time": "25m ago",
      "icon": "assets/icons/money_transfer.png" // Update with your asset path
    },
    {
      "title": "Money Transfer",
      "description": "You have successfully credited your wallet with ₦2500",
      "time": "9hr ago",
      "icon": "assets/icons/money_transfer.png" // Update with your asset path
    },
    {
      "title": "Payment Notification",
      "description": "Successfully paid!😜",
      "time": "July 13",
      "icon": "assets/icons/payment_notification.png" // Update with your asset path
    },
    {
      "title": "Top Up",
      "description": "Your top up is successfully!",
      "time": "July 13",
      "icon": "assets/icons/top_up.png" // Update with your asset path
    },
    {
      "title": "Payment Notification",
      "description": "Successfully paid!😜",
      "time": "July 10",
      "icon": "assets/icons/payment_notification.png" // Update with your asset path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: () {
              // Implement mark all as read functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          notification['icon']!,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['title']!,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(height: 4),
                              Text(
                                notification['description']!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          notification['time']!,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
