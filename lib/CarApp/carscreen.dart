
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/CarApp/car.dart';
import 'package:skisubapp/CarApp/cardetail.dart';

class CarBookingPage extends StatefulWidget {
  const CarBookingPage({super.key});

  @override
  _CarBookingPageState createState() => _CarBookingPageState();
}

class _CarBookingPageState extends State<CarBookingPage> {
  List<Car> cars = [];
  String? selectedCategory;
  bool isLoading = true;
  Timer? _debounce;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCarData(); // Initial fetch
  }

  Future<void> fetchCarData({String? keyword, String? category}) async {
    final dio = Dio();
    try {
      setState(() {
        isLoading = true;
      });

      final response = await dio.get(
        'https://skissub.pythonanywhere.com/car/api/cars/',
        queryParameters: {
          if (keyword != null) 'search': keyword,
          if (category != null) 'category': category,
        },
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

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchCarData(keyword: value); // Search by keyword
    });
  }

  Widget _filterButton(String label, String imagePath) {
    final Map<String, String> categoryMapping = {
      'SUV': 'Suv',
      'SEDAN': 'Sedan',
      'HILUX': 'Hilux',
      'BUS': 'Bus',
    };

    final isSelected = selectedCategory == categoryMapping[label];

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCategory = null; // Deselect to show all cars
            fetchCarData(); // Fetch all cars
          } else {
            selectedCategory = categoryMapping[label]; // Select category
            fetchCarData(category: selectedCategory);
          }
        });
      },
      child: Container(
        height: 75,
        width: 75,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white, // Highlight when selected
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                imagePath,
                height: 38,
                width: 38,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black, // Adjust text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _carCard({
    required Car car,
    required String image,
    required String name,
    required String year,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            image,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(year),
              const SizedBox(height: 5),
              Text(price),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Car Rentals',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        leading: null,
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Find your favourite vehicle',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Find vehicle.',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Model',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _filterButton('SUV', 'assets/images/png/automobile_icon.png'),
                      _filterButton('SEDAN', 'assets/images/png/sedan_icon.png'),
                      _filterButton('HILUX', 'assets/images/png/pickup_icon.png'),
                      _filterButton('BUS', 'assets/images/png/bus_icon.png'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'All Cars',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  cars.isEmpty
                      ? Center(
                          child: Text(
                            'Car category not available',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cars.length,
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
                                car: car,
                                image: car.images.first,
                                name: '${car.make} ${car.name}',
                                year: 'Year: ${car.year}',
                                price: '${car.pricePerDay} NGN / Day',
                              ),
                            );
                          },
                        ),
                ],
              ),
      ),
    );
  }
}
