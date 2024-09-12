import 'package:flutter/material.dart';
import 'package:skisubapp/dashboard.dart';
import 'package:skisubapp/home_screen.dart';

class BookingCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Summary'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              'Transaction Completed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Order has been Processed Successfully',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeView())); // Go back to the previous screen
              },
              child: Text('Done',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
              style: ElevatedButton.styleFrom(
                
                backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
                // Handle paying another bill or navigating somewhere else
              },
              child: Text('Pay Another Bill'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}