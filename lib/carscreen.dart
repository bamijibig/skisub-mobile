import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/car.dart';
import 'package:skisubapp/cardetail.dart';
// import 'package:skisubapp/CarDetailsPage.dart'; // Import your CarDetailsPage

class CarBookingPage extends StatefulWidget {
  @override
  _CarBookingPageState createState() => _CarBookingPageState();
}

class _CarBookingPageState extends State<CarBookingPage> {
  List<Car> cars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  Future<void> fetchCarData() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://skis.eu-west-1.elasticbeanstalk.com/car/api/cars/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Car> fetchedCars = data.map((carJson) => Car.fromJson(carJson)).toList();

        setState(() {
          cars = fetchedCars;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Car Rentals',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Find your favourite vehicle.',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _carTypeWidget('SUV', true),
                        _carTypeWidget('SEDAN', false),
                        _carTypeWidget('HILLUX', false),
                        _carTypeWidget('BUS', false),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      itemCount: cars.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final car = cars[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarDetailsPage(car: car),
                              ),
                            );
                          },
                          child: _carCard(
                            image: car.images.first,
                            name: '${car.make} ${car.name}',
                            price: '${car.pricePerDay} NGN / Day',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _carTypeWidget(String name, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Handle car type selection
        },
        child: Chip(
          label: Text(name),
          backgroundColor: isSelected ? Colors.blue[800] : Colors.grey[300],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _carCard({required String image, required String name, required String price}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.blue[800],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {
                      // Handle favorite toggle
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
