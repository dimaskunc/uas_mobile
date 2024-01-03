import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addkost.dart';
import 'updatekost.dart';
import 'user.dart';
import 'message.dart';
import 'api_manager.dart';

class ListKostPage extends StatelessWidget {
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Kost',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ListKostPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddKostPage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserPage()),
            );
          }
        },
      ),
    );
  }

  Widget buildKostCard(Map<String, dynamic> kostData, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Image.network(
          kostData['photo'],
          width: 50.0,
          height: 50.0,
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
            Text('Fasilitas : ${kostData['facilities']}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
    // Navigasi ke halaman UpdateKostPage dengan membawa data Kost yang akan diupdate
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateKostPage(kostData: kostData)),
    ).then((result) {
      // Refresh halaman jika update berhasil
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kost berhasil diupdate!'),
            duration: Duration(seconds: 2),
          ),
        );

         Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ListKostPage()),
                    );
                  });
      }
    });
  },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await apiManager.deleteKost(kostData['id']);
                  print('Delete Kost: ${kostData['name']}');

                  // Menampilkan notifikasi bahwa Kost berhasil dihapus
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kost berhasil dihapus!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Membuat fungsi async untuk menunggu sebentar sebelum mengarahkan ulang
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ListKostPage()),
                    );
                  });

                } catch (e) {
                  print('Error: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListKostPage(),
  ));
}
