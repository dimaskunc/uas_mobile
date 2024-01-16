import 'package:flutter/material.dart';

class DetailKostPage extends StatelessWidget {
  final Map<String, dynamic> kostData;

  DetailKostPage({required this.kostData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kost', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              kostData['photo'],
              width: 400,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              kostData['name'],
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(height: 10.0),
    Row(
      children: [
        Icon(Icons.home), // Ganti Icons.home dengan ikon yang sesuai
        SizedBox(width: 8.0),
        Text('Kost ${kostData['type']}'),
      ],
    ),
    SizedBox(height: 8.0),
    Row(
      children: [
        Icon(Icons.location_on), // Ganti Icons.location_on dengan ikon yang sesuai
        SizedBox(width: 8.0),
        Text('${kostData['location']}'),
      ],
    ),
    SizedBox(height: 8.0),
    Row(
      children: [
        Icon(Icons.attach_money), // Ganti Icons.attach_money dengan ikon yang sesuai
        SizedBox(width: 8.0),
        Text('${kostData['price']}'),
      ],
    ),
    SizedBox(height: 8.0),
    Row(
      children: [
        Icon(Icons.hotel), // Ganti Icons.hotel dengan ikon yang sesuai
        SizedBox(width: 8.0),
        Text('${kostData['facilities']}'),
      ],
    ),
  ],
)

          ],
        ),
      ),
    );
  }
}
