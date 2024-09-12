import 'package:flutter/material.dart';
import 'package:skisubapp/dashboard.dart';

class HotelConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image of the hotel confirmation
              Image.asset(
                'assets/images/png/checkout_image.png', // Replace with the actual image URL
                height: 400,
                width: 400,
                // fit: BoxFit.contain,
              ),
              
              SizedBox(height: 40.0),
              
              // Congratulations text
              Text(
                'Congratulations!!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Hotel stay secured text
              Text(
                'Your hotel stay is secured.\nCounting down to your dream vacation!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              Spacer(),
              
              // Home button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                 
                  backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                  // primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Implement Home button action
                  // Navigator.pop(context);
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
