import 'package:flutter/material.dart';

class BookCheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Car Rentals',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Section
            Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _overviewRow('HYUNDAI SANTAFE', 'YEAR: 2015'),
            SizedBox(height: 10),
            _overviewRow('Start', '16 Feb 2022'),
            _overviewRow('End', '16 Feb 2022'),
            _overviewRow('Pick Up Location', 'Ajah, Lagos'),
            _overviewRow('Driver Age', '34'),
            _overviewRow('Amount', 'NGN 75,000'),
            Spacer(),
            // Book and Pay Button
            ElevatedButton(
              onPressed: () {
                // Handle payment and booking
              },
              child: Text('Book and Pay Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                // primary: Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _overviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
