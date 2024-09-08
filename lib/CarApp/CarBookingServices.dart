// car_book_services.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/CarApp/BookingPreviewPage.dart';

class CarBookServices {
  final String apiUrl =
      'http://skis.eu-west-1.elasticbeanstalk.com/car/api/bookings/';

  // Format time to HH:mm
  String formatTime(String time) {
    try {
      DateTime parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat("HH:mm").format(parsedTime);
    } catch (e) {
      print("Time format error: $e");
      return time;
    }
  }

  // Select date picker
  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  // Select time picker
  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      controller.text =
          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
    }
  }

  // Booking a car
  Future<void> bookCar({
    required BuildContext context,
    required int carId,
    required TextEditingController pickUpDateController,
    required TextEditingController dropOffDateController,
    required TextEditingController pickUpTimeController,
    required TextEditingController dropOffTimeController,
    required TextEditingController pickUpLocationController,
    required TextEditingController dropOffLocationController,
    required TextEditingController driverAgeController,
  }) async {
    final dio = Dio();

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
      final pickupTimeFormatted = formatTime(pickUpTimeController.text);
      final dropoffTimeFormatted = formatTime(dropOffTimeController.text);

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
          "car": carId,
          "start_date": pickUpDateController.text,
          "end_date": dropOffDateController.text,
          "pickup_time": pickupTimeFormatted,
          "dropoff_time": dropoffTimeFormatted,
          "pickup_location": pickUpLocationController.text,
          "dropoff_location": dropOffLocationController.text,
          "age": int.tryParse(driverAgeController.text) ?? 0,
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
              bookingId: bookingId,
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
}
