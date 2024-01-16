import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_manager.dart';
import 'detailkost.dart';

class ListKostPageUser extends StatelessWidget {
  final ApiManager apiManager = ApiManager(baseUrl: 'http://127.0.0.1:8000/api');

  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('List Kost', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiManager.getKosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> kosts = snapshot.data!;
            return ListView.builder(
              itemCount: kosts.length,
              itemBuilder: (context, index) {
                return buildKostCard(kosts[index], context);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildKostCard(Map<String, dynamic> kostData, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Image.network(
          kostData['photo'],
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        title: Text(
          kostData['name'],
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kost ${kostData['type']}'),
            Text('${kostData['location']}'),
            Text('Rp ${kostData['price']}'),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailKostPage(kostData: kostData)),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListKostPageUser(),
  ));
}
