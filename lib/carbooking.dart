import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CarRentalsBookingPage extends StatefulWidget {
  final int carId;

  CarRentalsBookingPage({required this.carId});

  @override
  _CarRentalsBookingPageState createState() => _CarRentalsBookingPageState();
}

class _CarRentalsBookingPageState extends State<CarRentalsBookingPage> {
  // final storage = FlutterSecureStorage();
  TextEditingController _pickUpDateController = TextEditingController();
  TextEditingController _dropOffDateController = TextEditingController();
  TextEditingController _pickUpTimeController = TextEditingController();
  TextEditingController _dropOffTimeController = TextEditingController();
  TextEditingController _pickUpLocationController = TextEditingController();
  TextEditingController _dropOffLocationController = TextEditingController();
  TextEditingController _driverAgeController = TextEditingController();

  Future<void> _bookCar() async {
    final dio = Dio();
    final String apiUrl = 'http://skis.eu-west-1.elasticbeanstalk.com/car/api/booking/'; // Replace with your API URL

    try {
      // Retrieve token
      // final token = await storage.read(key: 'auth_token');

      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "id": 0, // Adjust these values as per your API requirements
          "user": 0, // This might be replaced with the actual user ID
          "car": widget.carId,
          "start_date": _pickUpDateController.text,
          "end_date": _dropOffDateController.text,
          "pickup_time": _pickUpTimeController.text,
          "dropoff_time": _dropOffTimeController.text,
          "pickup_location": _pickUpLocationController.text,
          "dropoff_location": _dropOffLocationController.text,
          "age": int.tryParse(_driverAgeController.text) ?? 0,
          "is_approved": false, // Adjust this based on your application logic
          "total_amount": "0", // Calculate and replace this with actual amount
        },
      );

      if (response.statusCode == 200) {
        // Handle successful booking
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking successful!')),
        );
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book car.')),
        );
      }
    } catch (e) {
      // Handle request error
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred.')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        controller.text = "${selectedTime.format(context)}";
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
            // Pick Up Location
            _inputField('Pick Up Location', _pickUpLocationController),
            SizedBox(height: 20),
            // Drop Off Location
            _inputField('Drop Off Location', _dropOffLocationController),
            SizedBox(height: 20),
            // Dates
            Row(
              children: [
                Expanded(
                  child: _inputField('Pick Up Date', _pickUpDateController),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _inputField('Drop Off Date', _dropOffDateController),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Times
            Row(
              children: [
                Expanded(
                  child: _inputField('Pick Up Time', _pickUpTimeController),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _inputField('Drop Off Time', _dropOffTimeController),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Driver Age
            _inputField('Driver Age', _driverAgeController),
            Spacer(),
            // Book Button
            ElevatedButton(
              onPressed: _bookCar,
              child: Text('Book'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                primary: Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController? controller) {
    return TextField(
      controller: controller,
      // readOnly: controller != null, // Make read-only if controller is not null
      keyboardType: hint.contains('Age') ? TextInputType.number : TextInputType.text, // Numeric keyboard for Age
      onTap: () {
        if (controller != null) {
          if (hint.contains('Date')) {
            _selectDate(context, controller);
          } else if (hint.contains('Time')) {
            _selectTime(context, controller);
          }
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
