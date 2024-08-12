import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/hotel.dart';
import 'package:skisubapp/hoteldetailscreen.dart';

class HotelListScreen extends StatefulWidget {
  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  List<Hotel> hotels = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchHotelData();
  }

  Future<void> fetchHotelData() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'http://skis.eu-west-1.elasticbeanstalk.com/hotelad/api/hotels/',
        options: Options(
          headers: {'content-type': 'application/json'},
        ),
      );

      // Debugging: Print the response data
      print('Response data: ${response.data}');

      // Check the response data for null and expected structure
      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          List<dynamic> data = response.data;

          // Parse JSON list into Hotel objects
          List<Hotel> fetchedHotels = data
              .map((hotelJson) => Hotel.fromJson(hotelJson))
              .toList();

          setState(() {
            hotels = fetchedHotels;
            isLoading = false;
          });
        } else {
          // Handle unexpected JSON structure
          setState(() {
            errorMessage = 'Unexpected data structure';
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load hotels: Invalid response');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Hotel By Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : GridView.builder(
                          itemCount: hotels.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final hotel = hotels[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HotelDetailsScreen(hotel: hotel),
                                  ),
                                );
                              },
                              child: _HotelListItem(
                                image: hotel.images.isNotEmpty
                                    ? hotel.images.first.image // Correctly accessing the image URL
                                    : 'https://via.placeholder.com/150',
                                name: hotel.name,
                                price: hotel.roomTypes.isNotEmpty
                                    ? '${hotel.roomTypes.first.pricePerDay} NGN / Day' // Access the first room type for price
                                    : 'No Rooms Available',
                                address: hotel.location,
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

  Widget _HotelListItem({
    required String image,
    required String name,
    required String address,
    required String price,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://via.placeholder.com/150',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  address,
                  style: TextStyle(
                    color: Colors.grey[600],
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
