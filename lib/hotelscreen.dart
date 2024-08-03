import 'package:flutter/material.dart';

class HotelListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
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
            // Date and Guest Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lekki',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '24 Oct - 26 Oct, 3 guests',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Search Bar
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
            // Recommended Hotels
            Expanded(
              child: ListView(
                children: [
                  HotelListItem(
                    imageUrl:
                        'https://via.placeholder.com/150', // Placeholder image URL
                    name: 'Terraform Hotel',
                    price: 'NGN 132,266.62 / Night',
                  ),
                  HotelListItem(
                    imageUrl:
                        'https://via.placeholder.com/150', // Placeholder image URL
                    name: 'Bricks Residence',
                    price: 'NGN 82,001.12 / Night',
                  ),
                  HotelListItem(
                    imageUrl:
                        'https://via.placeholder.com/150', // Placeholder image URL
                    name: 'Presken Hotels',
                    price: 'NGN 52,720.80 / Night',
                  ),
                  HotelListItem(
                    imageUrl:
                        'https://via.placeholder.com/150', // Placeholder image URL
                    name: 'Vintaton Hotel',
                    price: 'NGN 129,200.11 / Night',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;

  HotelListItem({
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Image.network(imageUrl, height: 150, fit: BoxFit.cover),
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
                    color: Colors.grey[700],
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
