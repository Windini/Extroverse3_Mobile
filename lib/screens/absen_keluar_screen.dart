import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extroverse/screens/status_absen_keluar_screen.dart';

class AbsenKeluarScreen extends StatelessWidget {
  final String namaKaryawan = 'Agus';
  final String peranKaryawan = 'Karyawan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absen Keluar'),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF001F54), // Navy Tua
              Color(0xFF003566), // Biru Sedikit Lebih Terang
              Color(0xFF006494), // Biru Sedang
              Color(0xFF669BBC), // Biru Muda
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              color: Color(0xFF001F54),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/icon/profil.png'),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $namaKaryawan',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        peranKaryawan,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Tersusuri di sini',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                ),
                 SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk cari alamat
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Membuat tombol berbentuk lingkaran
                    padding: EdgeInsets.all(12.0), // Warna latar tombol
                  ),
                  child: const Icon(
                    Icons.search, // Menambahkan ikon pencarian
                    color: Color.fromARGB(255, 59, 36, 199),// Warna ikon
                    size: 30.0, // Ukuran ikon
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(-6.3264, 108.3198), // Koordinat default
                  zoom: 14.0,
                ),
                myLocationEnabled: true,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatusAbsenKeluarScreen()),
                  );
                },
                child: Text('Absen Keluar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
