import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skisubapp/HotelApp/hotel.dart';
import 'package:skisubapp/HotelApp/hoteldetailscreen.dart';

class HotelListScreen extends StatefulWidget {
  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  List<Hotel> hotels = [];
  List<Hotel> filteredHotels = [];
  bool isLoading = true;
  String errorMessage = '';
  RangeValues priceRange = RangeValues(9000, 350000);
  int selectedRating = 0;
  String sortBy = 'Price Lower to Higher';

  @override
  void initState() {
    super.initState();
    fetchHotelData();
  }

  Future<void> fetchHotelData() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'http://127.0.0.1:8000/hotelad/api/hotels/',
        options: Options(
          headers: {'content-type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          List<dynamic> data = response.data;
          List<Hotel> fetchedHotels =
              data.map((hotelJson) => Hotel.fromJson(hotelJson)).toList();

          setState(() {
            hotels = fetchedHotels;
            filteredHotels = hotels;
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Unexpected data structure';
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load hotels: Invalid response');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading data: $e';
      });
    }
  }

  // Filter Hotels based on selected criteria
  void applyFilters() {
    setState(() {
      filteredHotels = hotels.where((hotel) {
        bool matchesRating = selectedRating == 0 || hotel.rating == selectedRating;
        bool matchesPrice = hotel.roomTypes.isNotEmpty &&
            hotel.roomTypes.first.pricePerDay >= priceRange.start &&
            hotel.roomTypes.first.pricePerDay <= priceRange.end;

        return matchesRating && matchesPrice;
      }).toList();

      if (sortBy == 'Price Lower to Higher') {
        filteredHotels.sort((a, b) => a.roomTypes.first.pricePerDay
            .compareTo(b.roomTypes.first.pricePerDay));
      } else if (sortBy == 'Price Higher to Lower') {
        filteredHotels.sort((a, b) => b.roomTypes.first.pricePerDay
            .compareTo(a.roomTypes.first.pricePerDay));
      }
    });
  }

  // Show the filter bottom sheet
  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(16, 0, 199, 1),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        sortBy = 'Price Lower to Higher';
                        selectedRating = 0;
                        priceRange = RangeValues(9000, 350000);
                        filteredHotels = hotels;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Reset'),
                  ),
                ],
              ),
              Divider(),
              // Sort By
              Text('Sort By'),
              DropdownButton<String>(
                value: sortBy,
                onChanged: (value) {
                  setState(() {
                    sortBy = value!;
                  });
                },
                items: [
                  'Price Lower to Higher',
                  'Price Higher to Lower',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              // Ratings
              Text('Ratings'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: selectedRating > index
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 10),
              // Price Ranges
              Text('Price Ranges'),
              RangeSlider(
                values: priceRange,
                min: 9000,
                max: 350000,
                divisions: 10,
                labels: RangeLabels(
                  'N${priceRange.start.toInt()}',
                  'N${priceRange.end.toInt()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    priceRange = values;
                  });
                },
              ),
              SizedBox(height: 20),
              // Apply Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(16, 0, 199, 1),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  applyFilters();
                  Navigator.pop(context);
                },
                child: Text('Apply', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 242, 242, 1),
      appBar: AppBar(
        title: Text('Hotels'),
        leading: null,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Hotel By Name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredHotels = hotels
                            .where((hotel) =>
                                hotel.name.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => showFilterBottomSheet(context),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(16, 0, 199, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.filter,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                'Recommended Hotels',
                style: TextStyle(
                  color: Color.fromRGBO(16, 0, 199, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.65,
                          children: List.generate(
                            filteredHotels.length,
                            (index) {
                              final hotel = filteredHotels[index];
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
                                      ? hotel.images.first.image
                                      : '',
                                  hotel: hotel,
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// Individual Hotel List Item
class _HotelListItem extends StatelessWidget {
  final String image;
  final Hotel hotel;

  const _HotelListItem({
    required this.image,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure pricePerDay is not null, default to 0.0 if it is
    double pricePerDay = hotel.roomTypes.isNotEmpty && hotel.roomTypes.first.pricePerDay != null
        ? hotel.roomTypes.first.pricePerDay!
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < hotel.rating
                          ? Icons.star
                          : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '₦${pricePerDay.toStringAsFixed(2)} per day',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

