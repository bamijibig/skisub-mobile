import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skisubapp/CarApp/car.dart'; // Import your Car model
import 'package:skisubapp/CarApp/carbooking.dart'; // Import your Booking Page

class CarDetailsPage extends StatelessWidget {
  final Car car;

  CarDetailsPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        backgroundColor: const Color.fromRGBO(251, 249, 249, 1),
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
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    '${car.make} ${car.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                     
                    ),
                    // Icon(
                    //   Icons.favorite,
                    //   color: Colors.yellow,
      
                    // )
                  ],
                ),
                SizedBox(height: 5,),
                Text('Year:${car.year}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 5,),
                Text(
                '${car.pricePerDay} NGN / Day',
                style: TextStyle(fontSize: 16, color: Color.fromRGBO(16,0,199,1), fontWeight: FontWeight.bold),
              ),
                  Image.asset(
                    'assets/images/png/cardetailine.png'
                  ),
                  SizedBox(height: 5,),
                  Text('Car Info',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _carInfoRow(Icons.person, '${car.numberOfPassengers} Passengers'),
                        _carInfoRow(Icons.ac_unit, car.airConditioning ? 'Air Conditioning' : 'No Air Conditioning'),
                        _carInfoRow(Icons.settings, car.transmission),
                      ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     _carInfoRow(Icons.door_sliding_outlined, '${car.numberOfDoors} Doors'),
              
                     _carInfoRow(Icons.local_gas_station, 'Fuel Type: ${car.fuelType}'),
                ],
              ),
                ],
              ),
             
              
             
              
              SizedBox(height: 20),
              Text(
                'Car Specs',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              
              _carSpecsRow('Max Power', '${car.maxPowerHp}','hp'),
              SizedBox(height: 5,),
              _carSpecsRow('Top Speed', '${car.topSpeedMph}','mph'),
              
              
                ],
              ),
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarRentalsBookingPage(carId: car.id),
                    ),
                  );
                },
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
          Icon(icon, color: Colors.black,),
          SizedBox(width: 10),
          Text(
            info,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _carSpecsRow(String spec, String value, String units,) {
    return 
        Container(
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
            color: Colors.black.withAlpha(100),
            width: 0.8,
            ),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  spec,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                              value,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
            Text(
              units,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
              ],
            ),
          ),
        );
        
          
      
  }
}
