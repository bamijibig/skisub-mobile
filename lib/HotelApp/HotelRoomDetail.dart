import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skisubapp/HotelApp/HotelRoomBooking.dart';
import 'package:skisubapp/HotelApp/hotel.dart';

class HotelRoomDetailsScreen extends StatelessWidget {
  final Hotel hotel;

  HotelRoomDetailsScreen({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'en_NG', // Nigerian locale
    symbol: '₦', // Currency symbol for Naira
    decimalDigits: 0, // You can adjust this to show decimal points if needed
  );
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: hotel.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    hotel.images[index].image,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 4),
                      Text(hotel.location),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Room Types',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // List of room types
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hotel.roomTypes.length,
                    itemBuilder: (context, index) {
                      final roomType = hotel.roomTypes[index];
                      
                      

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              hotel.images.first.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    roomType.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    // 'NGN ${roomType.pricePerDay.toStringAsFixed(2)} /Night',
                                    '${currencyFormat.format(roomType.pricePerDay)} per day',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(16, 0, 199, 1)),
                              onPressed: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=>HotelBookingScreen(hotel: hotel, roomType: roomType)));
                              },
                              
                              child: Text('Book Now',
                              style: TextStyle(
                                color:Colors.white,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
