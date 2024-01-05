import 'user.dart';
import 'message.dart';
import 'listkost.dart';
import 'api_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
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

  File? _image;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  Future<void> _addKostKost() async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);
    if (_image != null) {    
      String nama = _namaController.text;
      String tipe = _tipeController.text;
      String foto = _fotoController.text;
      String lokasi = _lokasiController.text;
      String harga = _hargaController.text;
      String fasilitas = _fasilitasController.text;

      dynamic result = await apiManager.addKost(_image!, nama, tipe, harga, lokasi, fasilitas);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            SizedBox(height: 16),
            _image != null
                ? Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                  )
                : Container(),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addKostKost,
              child: Text('Add Kost'),
            ),
          ],
        ),
      ),
    );
  }
}