import 'package:flutter/material.dart';

class HotelDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Image
              Image.network(
                'https://via.placeholder.com/600x300', // Placeholder image URL
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              // Hotel Name
              Text(
                'Terraform Hotel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Information
              Text(
                'Information about Terraform Hotel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Terraform Hotel is a world-class deluxe hotel in Lagos Nigeria. The hotel is located at Victoria Island, Lagos. It is a luxurious place with a breathtaking view of the ocean.',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // Amenities
              Text(
                'Amenities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Free Wi-Fi, Swimming Pool, Bar, Restaurant, Fitness Center, Air Conditioning, 24-hour Security, Car Hire',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // Terms and Conditions
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Check-in: 12:00pm\nCheck-out: 11:00am\nPets: Pets are not allowed.',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 30),
              // Rooms Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Rooms screen
                },
                child: Text('Rooms'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  primary: Colors.blue[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
