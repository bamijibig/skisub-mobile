
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:skisubapp/CarApp/car.dart';
// import 'package:skisubapp/CarApp/cardetail.dart';

// class CarBookingPage extends StatefulWidget {
//   const CarBookingPage({super.key});

//   @override
//   _CarBookingPageState createState() => _CarBookingPageState();
// }

// class _CarBookingPageState extends State<CarBookingPage> {
//   List<Car> cars = [];
//   bool isLoading = true;
//   Timer? _debounce;
//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchCarData();
//   }

//   Future<void> fetchCarData({String? keyword}) async {
//     final dio = Dio();

//     try {
//       final response = await dio.get(
//         'http://skis.eu-west-1.elasticbeanstalk.com/car/api/cars/',
//         queryParameters: keyword != null ? {'search': keyword} : null,
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;
//         List<Car> fetchedCars = data.map((carJson) => Car.fromJson(carJson)).toList();

//         setState(() {
//           cars = fetchedCars;
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load cars');
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _onSearchChanged(String value) {
//     if (_debounce?.isActive ?? false) {
//       _debounce?.cancel();
//     }
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       fetchCarData(keyword: value);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Car Rentals',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: Text(
//                       'Find your favourite',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: Text(
//                       'vehicle',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   TextField(
//                     controller: _searchController,
//                     onChanged: _onSearchChanged,
//                     decoration: InputDecoration(
//                       hintText: 'Find vehicle.',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: Text(
//                       'Model',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _filterButton('SUV', 'assets/images/png/automobile_icon.png'),
//                       _filterButton('SEDAN', 'assets/images/png/sedan_icon.png'),
//                       _filterButton('HILUX', 'assets/images/png/pickup_icon.png'),
//                       _filterButton('BUS', 'assets/images/png/bus_icon.png'),
//                     ],
//                   ),
//                   SizedBox(height: 15),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: Text(
//                       'All Cars',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   GridView.count(
//                     physics: const NeverScrollableScrollPhysics(),
//                     crossAxisCount: 2,
//                     shrinkWrap: true,
//                     mainAxisSpacing: 20,
//                     crossAxisSpacing: 20,
//                     childAspectRatio: 0.75,
//                     children: cars.map(
//                       (car) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CarDetailsPage(car: car),
//                               ),
//                             );
//                           },
//                           child: _carCard(
//                             image: car.images.first,
//                             name: '${car.make} ${car.name}',
//                             year: 'Year: ${car.year}',
//                             price: '${car.pricePerDay}NGN/Day',
//                           ),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _filterButton(String label, String imagePath) {
//     return Container(
//       height: 75,
//       width: 75,
//       margin: const EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Image.asset(
//               imagePath,
//               height: 38,
//               width: 38,
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _carCard({required String image, required String name, required String year, required String price}) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15.0),
//             child: Image.network(
//               image,
//               height: 114,
//               width: 149,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // Icon(
//                     //   Icons.favorite,
//                     //   color: Colors.yellow,
//                     // ),
//                   ],
//                 ),
//                 Text(
//                   year,
//                   style: TextStyle(
//                     color: Colors.blue[800],
//                   ),
//                 ),
//                 Text(
//                   price,
//                   style: TextStyle(
//                     color: Colors.blue[800],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  bool isLoading = true;
  Timer? _debounce;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  Future<void> fetchCarData({String? keyword}) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://skis.eu-west-1.elasticbeanstalk.com/car/api/cars/',
        queryParameters: keyword != null ? {'search': keyword} : null,
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
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchCarData(keyword: value);
    });
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
      body: SingleChildScrollView(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'Find your favourite',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'vehicle',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
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
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'All Cars',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
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

  Widget _filterButton(String label, String imagePath) {
    return Container(
      height: 75,
      width: 75,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _carCard({required Car car, required String image, required String name, required String year, required String price}) {
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
            offset: Offset(0, 1), // Changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  year,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(16, 0, 199, 1),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(car: car)
                            ),
                          );
            },
            style: ElevatedButton.styleFrom(
              // primary: Colors.blue[800],
              backgroundColor: Color.fromRGBO(16, 0, 199, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            child: Text(
              'Book Now',
              style: TextStyle(fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
