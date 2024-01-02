import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'message.dart';
import 'listkost.dart';
import 'api_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddKostPage extends StatefulWidget {
  @override
  _AddKostPageState createState() => _AddKostPageState();
}

class _AddKostPageState extends State<AddKostPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tipeController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _fasilitasController = TextEditingController();
  File? _selectedImage;

  void _addKostKost(BuildContext context) async {
    final apimanager = Provider.of<ApiManager>(context, listen: false);

    String nama = _namaController.text;
    String tipe = _tipeController.text;
    String foto = _fotoController.text;
    String lokasi = _lokasiController.text;
    String harga = _hargaController.text;
    String fasilitas = _fasilitasController.text;

    if (nama.isEmpty || tipe.isEmpty || foto.isEmpty || lokasi.isEmpty || harga.isEmpty || fasilitas.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Semua field harus diisi!'),
        duration: Duration(seconds: 2),
      ),
    );
    return; // Hentikan eksekusi metode jika ada inputan yang kosong
  }

    try {
      await apimanager.addKost(nama, tipe, foto, lokasi, harga, fasilitas);

      Navigator.pushReplacementNamed(context, '/listkost');
      // Tampilkan notifikasi bahwa Kost berhasil ditambahkan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kost berhasil ditambahkan!'),
          duration: Duration(seconds: 2),
        ),
      );
      // Navigasi kembali ke halaman sebelumnya atau sesuai kebutuhan aplikasi
      Navigator.pop(context);
    } catch (e) {
      // Tampilkan notifikasi bahwa terjadi kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Coba lagi nanti.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Metode untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _fotoController.text = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Kost', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _pickImage,
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 8.0),
                    Text('Input Foto Kost'),
                  ],
                ),
              ),
            ),
            // Tampilkan gambar yang dipilih
            if (_selectedImage != null)
              Container(
                margin: EdgeInsets.only(top: 16.0),
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 10.0),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Kost'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _tipeController,
              decoration: InputDecoration(labelText: 'Tipe Kost'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi Kost'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _hargaController,
              decoration: InputDecoration(labelText: 'Harga Kost'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _fasilitasController,
              decoration: InputDecoration(labelText: 'Fasilitas Kost'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                _addKostKost(context);
              },
              child: Text('Add Kost'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
}
