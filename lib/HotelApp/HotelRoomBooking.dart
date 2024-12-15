
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/HotelApp/HotelBookingPreviewPage.dart';
import 'package:skisubapp/HotelApp/hotel.dart';

class HotelBookingScreen extends StatefulWidget {
  final Hotel hotel;
  final RoomType roomType;

  HotelBookingScreen({required this.hotel, required this.roomType});

  @override
  _HotelBookingScreenState createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;
  int numroom = 1;

  // TextEditingController instances to capture input data
  final TextEditingController _checkInDateController = TextEditingController();
  final TextEditingController _checkOutDateController = TextEditingController();
  final TextEditingController _checkInTimeController = TextEditingController(text: "14:00");
  final TextEditingController _checkOutTimeController = TextEditingController(text: "12:00");

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          _checkInDateController.text = "${picked.year}-${picked.month}-${picked.day}";
        } else {
          checkOutDate = picked;
          _checkOutDateController.text = "${picked.year}-${picked.month}-${picked.day}";
        }
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
        controller.text =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _submitBooking() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? 0;
    final token = prefs.getString('auth_token') ?? '';

    if (checkInDate == null || checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both check-in and check-out dates.')),
      );
      return;
    }

    final bookingData = {
      "room_type": widget.roomType.id,
      "check_in_date": _checkInDateController.text,
      "check_out_date": _checkOutDateController.text,
      "check_in_time": _checkInTimeController.text,
      "check_out_time": _checkOutTimeController.text,
      "total_amount": 0,
      "guest": guests,
      "number_of_rooms": numroom,
      "user_id": userId,
    };

    final dio = Dio();
    final String apiUrl = 'https://jpowered.pythonanywhere.com/hotelad/api/hotelbooking/';

    try {
      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $token',
          },
        ),
        data: bookingData,
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final bookingId = response.data['id'];
        final booking = response.data;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelBookingPreviewPage(booking: booking, hotel: widget.hotel, roomType:widget.roomType),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book the room.')),
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
          SnackBar(content: Text('please fund wallet, insufficient fund.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please fund wallet, insufficient fund.')),
      );
    }
  }

  Widget _inputField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.access_time),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              widget.hotel.images.first.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 240.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book Your Stay',

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(16, 0, 199, 1)
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _checkInDateController,
                                decoration: InputDecoration(
                                  hintText: 'Check-in',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _checkOutDateController,
                                decoration: InputDecoration(
                                  hintText: 'Check-out',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
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
                            onTap: () => _selectTime(context, _checkInTimeController),
                            child: AbsorbPointer(
                              child: _inputField('Check-in Time', _checkInTimeController),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context, _checkOutTimeController),
                            child: AbsorbPointer(
                              child: _inputField('Check-out Time', _checkOutTimeController),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Guests',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (guests > 1) guests--;
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text('$guests'),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        guests++;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'No of Room',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (numroom > 1) numroom--;
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text('$numroom'),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        numroom++;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitBooking,
                        child: Text('Continue',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(16,0,199,1),
                              minimumSize: Size(double.infinity, 50),
                              // : Colors.blue[800],
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

