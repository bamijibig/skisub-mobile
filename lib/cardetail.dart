import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skisubapp/car.dart'; // Import your Car model
import 'package:skisubapp/carbooking.dart'; // Import your Booking Page

class CarDetailsPage extends StatelessWidget {
  final Car car;

  CarDetailsPage({required this.car});

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
          'Car Details',
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
              CarouselSlider(
                items: car.images.map((img) => Image.network(img, fit: BoxFit.cover)).toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${car.make} ${car.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${car.pricePerDay} NGN / Day',
                style: TextStyle(fontSize: 18, color: Colors.blue[800]),
              ),
              SizedBox(height: 20),
              _carInfoRow(Icons.person, '${car.numberOfPassengers} Passengers'),
              _carInfoRow(Icons.door_sliding_outlined, '${car.numberOfDoors} Doors'),
              _carInfoRow(Icons.ac_unit, car.airConditioning ? 'Air Conditioning' : 'No Air Conditioning'),
              _carInfoRow(Icons.local_gas_station, 'Fuel Type: ${car.fuelType}'),
              _carInfoRow(Icons.settings, car.transmission),
              SizedBox(height: 20),
              _carSpecsRow('Max Power', '${car.maxPowerHp} hp'),
              _carSpecsRow('Top Speed', '${car.topSpeedMph} mph'),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarRentalsBookingPage(carId: car.id),
                    ),
                  );
                },
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  // primary: Colors.blue[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _carInfoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          SizedBox(width: 10),
          Text(
            info,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _carSpecsRow(String spec, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            spec,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
