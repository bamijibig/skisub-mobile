import 'package:flutter/material.dart';
import 'package:skisubapp/CarApp/CarBookingServices.dart';

class CarRentalsBookingPage extends StatefulWidget {
  final int carId;

  CarRentalsBookingPage({required this.carId});

  @override
  _CarRentalsBookingPageState createState() => _CarRentalsBookingPageState();
}

class _CarRentalsBookingPageState extends State<CarRentalsBookingPage> {
  final TextEditingController _pickUpDateController = TextEditingController();
  final TextEditingController _dropOffDateController = TextEditingController();
  final TextEditingController _pickUpTimeController = TextEditingController();
  final TextEditingController _dropOffTimeController = TextEditingController();
  final TextEditingController _pickUpLocationController = TextEditingController();
  final TextEditingController _dropOffLocationController = TextEditingController();
  final TextEditingController _driverAgeController = TextEditingController();
  final CarBookServices _carBookServices = CarBookServices();

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
                    onTap: () =>
                        _carBookServices.selectDate(context, _pickUpDateController),
                    child: AbsorbPointer(
                      child: _inputField('Pick Up Date', _pickUpDateController),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        _carBookServices.selectDate(context, _dropOffDateController),
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
                    onTap: () =>
                        _carBookServices.selectTime(context, _pickUpTimeController),
                    child: AbsorbPointer(
                      child: _inputField('Pick Up Time', _pickUpTimeController),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        _carBookServices.selectTime(context, _dropOffTimeController),
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
              onPressed: () {
                _carBookServices.bookCar(
                  context: context,
                  carId: widget.carId,
                  pickUpDateController: _pickUpDateController,
                  dropOffDateController: _dropOffDateController,
                  pickUpTimeController: _pickUpTimeController,
                  dropOffTimeController: _dropOffTimeController,
                  pickUpLocationController: _pickUpLocationController,
                  dropOffLocationController: _dropOffLocationController,
                  driverAgeController: _driverAgeController,
                );
              },
              child: Text('Book',
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

  Widget _inputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType:
          hint.contains('Age') ? TextInputType.number : TextInputType.text,
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
