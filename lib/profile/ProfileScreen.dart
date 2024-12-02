import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/png/profile_image.png'), // Replace with your image
            ),
            SizedBox(height: 16),
            Text(
              'Johnson Jason',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'ebegbej@mail.com',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement photo upload
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(height: 20),
            
            // Converted ListTile to Container for Personal Information
            GestureDetector(
              onTap: () {
                // Navigate to personal information page
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        'Personal Information',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
            ),
            
            // Converted ListTile to Container for Settings
            GestureDetector(
              onTap: () {
                // Navigate to settings page
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
            ),
            
            // Add more custom containers as needed
          ],
        ),
      ),
    );
  }
}
