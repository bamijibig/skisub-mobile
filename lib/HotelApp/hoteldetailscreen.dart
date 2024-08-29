import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skisubapp/HotelApp/HotelRoomDetail.dart';
 // Import your HotelRoomDetailsScreen class
import 'package:skisubapp/HotelApp/hotel.dart'; // Import your Hotel model

class HotelDetailsScreen extends StatelessWidget {
  final Hotel hotel;

  HotelDetailsScreen({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Hotel Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider for Hotel Images
              CarouselSlider(
                items: hotel.images
                    .map((img) => Image.network(img.image, fit: BoxFit.cover)) // Accessing image URL
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
              ),
              SizedBox(height: 20),
              // Hotel Name
              Text(
                hotel.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Hotel Location
              Text(
                hotel.location,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              // Information Section
              Text(
                'Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                hotel.description,
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // Amenities Section
              Text(
                'Amenities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                hotel.amenities.map((a) => a.name).join(', '), // Joining amenities names
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              
             
              // Terms and Conditions Section
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
              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelRoomDetailsScreen(hotel:hotel),
                    ),
                  );
                  // Navigate to booking screen or perform booking action
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  // color: Colors.blue[800], // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build room types list
  // Widget _buildRoomTypesList() {
  //   return Column(
  //     children: hotel.roomTypes.map((roomType) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: ListTile(
  //             leading: Icon(Icons.king_bed, color: Colors.blue[800]),
  //             title: Text(
  //               roomType.name, // Room type name
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //             subtitle: Text(
  //               'Price: ${roomType.pricePerDay} NGN / Day\nAvailable: ${roomType.available ? 'Yes' : 'No'}',
  //               style: TextStyle(color: Colors.grey[600]),
  //             ),
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
}
