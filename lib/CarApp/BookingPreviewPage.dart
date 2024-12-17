
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/CarApp/BookingCompletePage.dart';

class BookingPreviewPage extends StatefulWidget {
  final int bookingId;

  BookingPreviewPage({required this.bookingId});

  @override
  _BookingPreviewPageState createState() => _BookingPreviewPageState();
}

class _BookingPreviewPageState extends State<BookingPreviewPage> {
  Map<String, dynamic>? bookingData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookingDetails();
  }

  Future<void> _fetchBookingDetails() async {
    final dio = Dio();
    final String apiUrl = 'http://127.0.0.1:8000/car/api/listcarbooking/${widget.bookingId}/';

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User is not authenticated.')),
        );
        return;
      }

      final formattedToken = 'Token $token';

      final response = await dio.get(apiUrl,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': formattedToken,
          }));

      if (response.statusCode == 200) {
        setState(() {
          bookingData = response.data;
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch booking details.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while fetching data.')),
      );
    }
  }

  Future<void> _confirmBooking(BuildContext context) async {
    final dio = Dio();
    final String apiUrl = 'http://127.0.0.1:8000/car/api/orders/';

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
            "booking": widget.bookingId,
            "status": "confirmed",
            // "total_amount":bookingData!['total_amount']
          });
          

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookingCompletePage()),
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
        SnackBar(content: Text('fund wallet or insufficient fund.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'en_NG', // Nigerian locale
    symbol: '₦', // Currency symbol for Naira
    decimalDigits: 0, // You can adjust this to show decimal points if needed
  );
    final double pricePerDay = double.tryParse(bookingData!['total_amount']) ?? 0;
    final formattedPrice = currencyFormat.format(pricePerDay);
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Rentals'),
      ),
      
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookingData == null
              ? Center(child: Text('Booking not found'))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bookingData!['car']['model']['name']}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'YEAR: ${bookingData!['car']['year']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              title: 'Start',
                              value: '${bookingData!['start_date']}',
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildInfoCard(
                              title: 'End',
                              value: '${bookingData!['end_date']}',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Pick Up location',
                        value: '${bookingData!['pickup_location']}',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Driver Age',
                        value: '${bookingData!['age']}',
                        icon: Icons.person,
                      ),
                      SizedBox(height: 16),
                      _buildInfoCard(
                        
                        title: 'Amount',
                        // value: 'NGN ${bookingData!['total_amount']}',
                        
                        value: formattedPrice,
                        icon: Icons.monetization_on,
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          _confirmBooking(context);
                        },
                        child: Text('Book and Pay Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                        style: ElevatedButton.styleFrom(
                          
                          backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoCard({required String title, required String value, IconData? icon}) {
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.grey[600]),
              SizedBox(width: 8),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

