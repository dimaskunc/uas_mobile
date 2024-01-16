import 'package:flutter/material.dart';
import 'api_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateKostPage extends StatefulWidget {
  final Map<String, dynamic> kostData;
  final ApiManager apiManager = ApiManager(baseUrl: 'http://127.0.0.1:8000/api');

  UpdateKostPage({required this.kostData});

  @override
  _UpdateKostPageState createState() => _UpdateKostPageState();
}

class _UpdateKostPageState extends State<UpdateKostPage> {
  late TextEditingController _idController;
  late TextEditingController _namaController;
  late TextEditingController _tipeController;
  late TextEditingController _fotoController;
  late TextEditingController _lokasiController;
  late TextEditingController _hargaController;
  late TextEditingController _fasilitasController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    _idController = TextEditingController(text: widget.kostData['id'].toString());
    _namaController = TextEditingController(text: widget.kostData['name']);
    _tipeController = TextEditingController(text: widget.kostData['type']);
    _fotoController = TextEditingController(text: widget.kostData['photo']);
    _lokasiController = TextEditingController(text: widget.kostData['location']);
    _hargaController = TextEditingController(text: widget.kostData['price'].toString());
    _fasilitasController = TextEditingController(text: widget.kostData['facilities']);
  }

  @override
  void dispose() {
    _idController.dispose();
    _namaController.dispose();
    _tipeController.dispose();
    _fotoController.dispose();
    _lokasiController.dispose();
    _hargaController.dispose();
    _fasilitasController.dispose();
    super.dispose();
  }

  void _updateKost(BuildContext context) async {
    String id = _idController.text;
    String nama = _namaController.text;
    String tipe = _tipeController.text;
    String foto = _fotoController.text;
    String lokasi = _lokasiController.text;
    String harga = _hargaController.text;
    String fasilitas = _fasilitasController.text;

    if (nama.isEmpty || tipe.isEmpty || lokasi.isEmpty || harga.isEmpty || fasilitas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi!'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await widget.apiManager.updateKost(
        id,
        nama,
        tipe,
        foto,
        lokasi,
        harga,
        fasilitas,
      );

      // Menampilkan notifikasi bahwa Kost berhasil diupdate
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kost berhasil diupdate!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigasi kembali ke halaman sebelumnya atau sesuai kebutuhan aplikasi
      Navigator.pop(context, true);
    } catch (e) {
      // Menampilkan notifikasi bahwa terjadi kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Coba lagi nanti. $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
        title: Text('Update Kost', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        iconTheme: IconThemeData(color: Colors.white),
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
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'Id'),
            ),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Kost'),
            ),
            TextField(
              controller: _tipeController,
              decoration: InputDecoration(labelText: 'Tipe Kost'),
            ),
            TextField(
              controller: _lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi Kost'),
            ),
            TextField(
              controller: _hargaController,
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: _fasilitasController,
              decoration: InputDecoration(labelText: 'Fasilitas'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                _updateKost(context);
              },
              child: Text('Update Kost'),
            ),
          ],
        ),
      ),
    );
  }
}
