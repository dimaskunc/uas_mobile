import 'package:flutter/material.dart';
import 'user.dart';
import 'addkost.dart';
import 'listkost.dart';
import 'api_manager.dart';
import 'message.dart';

class DashboardPage extends StatelessWidget {
  final ApiManager apiManager;

  DashboardPage({required this.apiManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Tambahkan aksi Anda saat tombol notifikasi diklik
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi,',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text('Temukan Kost Impianmu'),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari kost di sini',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              'Rekomendasi Kost',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Contoh card rekomendasi kost
                  buildKostCard('assets/kost 1.jpg', 'Kost Berkah', '3', 'Jakarta', 'Rp 500.000/bulan'),
                  buildKostCard('assets/kost 2.jpg', 'Kost Mandiri', '5', 'Bandung', 'Rp 300.000/bulan'),
                  buildKostCard('assets/kost 3.jpg', 'Kost Ceria', '2',  'Surabaya', 'Rp 400.000/bulan'),
                  buildKostCard('assets/kost 4.jpg', 'Kost Maju', '4', 'Yogyakarta', 'Rp 450.000/bulan'),
                  buildKostCard('assets/kost 5.jpg', 'Kost Pertiwi', '6', 'Purwokerto', 'Rp 250.000/bulan'),
                  // Tambahkan card rekomendasi kost lainnya sesuai kebutuhan
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
              'Promo Hari Ini',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Lihat Semua',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
            ),
              ],
            ),
            SizedBox(height: 10.0),
          Container(
  height: 120.0,
  child: SizedBox(
    height: 110.0,
    child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      children: [
        buildPromoCard('assets/kost 6.jpg', 'Diskon 30%', 'Kost Prima', 'Jakarta'),
        SizedBox(height: 8.0), // Tambahkan spasi di antara card
        buildPromoCard('assets/kost 7.jpg', 'Gratis Wi-Fi', 'Kost Griya', 'Bandung'),
        SizedBox(height: 8.0),
        buildPromoCard('assets/kost 8.jpeg', 'Cashback 50%', 'Kost Kartiko', 'Surabaya'),
        SizedBox(height: 8.0),
        buildPromoCard('assets/kost 9.jpg', 'Gratis Wi-Fi', 'Kost Pama', 'Purwokerto'),
        SizedBox(height: 8.0),
        buildPromoCard('assets/kost 10.jpg', 'Diskon 25%', 'Kost Vereta', 'Semarang'),
        // Tambahkan card promo lainnya sesuai kebutuhan
      ],
    ),
  ),
),

          ],
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,  // Set sesuai dengan index halaman 'User'
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
          // Handle navigation to other pages
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

  Widget buildKostCard(String image, String type, String roomsLeft, String location, String price) {
    return Card(
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: 150.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: TextStyle(color: Colors.blue)),
                Text('Sisa Kamar: $roomsLeft'),
                Text(location),
                Text(price),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget buildPromoCard(String image, String discount, String name, String location) {
  return Card(
    margin: EdgeInsets.only(right: 16.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar promo
          Image.asset(
            image,
            width: 100.0,
            height: 70.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 8.0), // Spasi antara gambar dan teks deskripsi
          // Teks diskon dan informasi lainnya di samping gambar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discount,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2.0),
                Text(
                  location,
                  style: TextStyle(fontStyle: FontStyle.italic),
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

