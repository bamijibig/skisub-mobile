import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/HotelApp/PaymentConfirmPage.dart';
import 'hotel.dart';

class HotelBookingPreviewPage extends StatelessWidget {
  final Map<String, dynamic> booking;
  final Hotel hotel;
  final RoomType roomType;

  HotelBookingPreviewPage({
    required this.booking,
    required this.hotel,
    required this.roomType,
  });

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_NG', symbol: '₦');
    return formatCurrency.format(amount);
  }

  int calculateDaysDifference(String checkInDate, String checkOutDate) {
    final checkIn = DateFormat('yyyy-MM-dd').parse(checkInDate);
    final checkOut = DateFormat('yyyy-MM-dd').parse(checkOutDate);
    return checkOut.difference(checkIn).inDays;
  }

 Future<void> _confirmhotelBooking(BuildContext context) async {
    final dio = Dio();
    final String apiUrl = 'http://skis.eu-west-1.elasticbeanstalk.com/hotelad/api/orders/';

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      final int? userId = prefs.getInt('user_id');

      if (token == null || userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User is not authenticated.')),
        );
        return;
      }

      final formattedToken = 'Token $token';
      final response = await dio.post(apiUrl,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': formattedToken,
          }),
          data: {
            "user": userId,
            "booking": booking['id'],
            "status": "confirmed",
            "total_amount":booking['total_amount']
            // "total_amount":bookingData!['total_amount']
          });
          // Log the response status code and data
          print('Response status code: ${response.statusCode}');
          print('Response data: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HotelConfirmationPage()),
        );
      } else {
        // Print response data for debugging
      print('Error response data: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to confirm booking.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while confirming booking.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // Calculate the number of days
    int numberOfDays = calculateDaysDifference(booking['check_in_date'], booking['check_out_date']);
    numberOfDays = numberOfDays < 1 ? 1 : numberOfDays;

    // Calculate the total amount
    double totalAmount = roomType.pricePerDay * booking['number_of_rooms'] * numberOfDays;

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Summary'),
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.network(
                      hotel.images.first.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      hotel.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hotel.location),
                        SizedBox(height: 5),
                        Text(
                          roomType.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          '${formatCurrency(roomType.pricePerDay)} /Night',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        _buildRow('Booking Date', DateFormat('d-MMM-yyyy').format(DateTime.now())),
                        SizedBox(height: 10),
                        _buildRow('Check-in', booking['check_in_date']),
                        SizedBox(height: 10),
                        _buildRow('Check-out', booking['check_out_date']),
                        SizedBox(height: 10),
                        _buildRow('Guests', booking['guest'].toString()),
                        SizedBox(height: 10),
                        _buildRow('Apartment', roomType.name), // You may need to replace this
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${formatCurrency(roomType.pricePerDay)} x ${booking['number_of_rooms']} rooms x $numberOfDays nights',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatCurrency(totalAmount),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () 
              {
                 _confirmhotelBooking(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Pay Now',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
 

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
