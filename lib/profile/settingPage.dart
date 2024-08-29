import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Reset Password'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to reset password page
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to notifications page
              },
            ),
            ListTile(
              leading: Icon(Icons.person_remove),
              title: Text('Deactivate / Delete Account'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to deactivate/delete account page
              },
            ),
            // Add more settings options if needed
          ],
        ),
      ),
    );
  }
}
