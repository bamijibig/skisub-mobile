

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/CarApp/BookingPreviewPage.dart';

class CarRentalsBookingPage extends StatefulWidget {
  final int carId;

  CarRentalsBookingPage({required this.carId});

  @override
  _CarRentalsBookingPageState createState() => _CarRentalsBookingPageState();
}

class _CarRentalsBookingPageState extends State<CarRentalsBookingPage> {
  TextEditingController _pickUpDateController = TextEditingController();
  TextEditingController _dropOffDateController = TextEditingController();
  TextEditingController _pickUpTimeController = TextEditingController();
  TextEditingController _dropOffTimeController = TextEditingController();
  TextEditingController _pickUpLocationController = TextEditingController();
  TextEditingController _dropOffLocationController = TextEditingController();
  TextEditingController _driverAgeController = TextEditingController();

  Future<void> _bookCar() async {
    final dio = Dio();
    final String apiUrl =
        'http://skis.eu-west-1.elasticbeanstalk.com/car/api/bookings/';

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

      final String pickupTimeFormatted = _formatTime(_pickUpTimeController.text);
      final String dropoffTimeFormatted = _formatTime(_dropOffTimeController.text);

      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': formattedToken,
          },
        ),
        data: {
          "user": userId,
          "car": widget.carId,
          "start_date": _pickUpDateController.text,
          "end_date": _dropOffDateController.text,
          "pickup_time": pickupTimeFormatted,
          "dropoff_time": dropoffTimeFormatted,
          "pickup_location": _pickUpLocationController.text,
          "dropoff_location": _dropOffLocationController.text,
          "age": int.tryParse(_driverAgeController.text) ?? 0,
          "is_approved": true,
          "total_amount": "0", // Calculate and replace this with actual amount
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bookingId = response.data['id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingPreviewPage(
              bookingId: bookingId
              
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book car.')),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Endpoint not found. Please check the URL.')),
        );
      } else if (e.response?.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bad request. Please check the input data.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }

  String _formatTime(String time) {
    try {
      DateTime parsedTime = DateFormat("HH:mm").parse(time);
      String formattedTime = DateFormat("HH:mm").format(parsedTime);
      return formattedTime;
    } catch (e) {
      print("Time format error: $e");
      return time;
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        controller.text =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

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
          'Car Rentals Booking',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inputField('Pick Up Location', _pickUpLocationController),
            SizedBox(height: 20),
            _inputField('Drop Off Location', _dropOffLocationController),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, _pickUpDateController),
                    child: AbsorbPointer(
                      child: _inputField('Pick Up Date', _pickUpDateController),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, _dropOffDateController),
                    child: AbsorbPointer(
                      child: _inputField('Drop Off Date', _dropOffDateController),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, _pickUpTimeController),
                    child: AbsorbPointer(
                      child: _inputField('Pick Up Time', _pickUpTimeController),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, _dropOffTimeController),
                    child: AbsorbPointer(
                      child: _inputField('Drop Off Time', _dropOffTimeController),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _inputField('Driver Age', _driverAgeController),
            Spacer(),
            ElevatedButton(
              onPressed: _bookCar,
              child: Text('Book'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType:
          hint.contains('Age') ? TextInputType.number : TextInputType.text,
      onTap: () {
        if (hint.contains('Date')) {
          _selectDate(context, controller);
        } else if (hint.contains('Time')) {
          _selectTime(context, controller);
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}