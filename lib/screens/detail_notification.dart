import 'package:flutter/material.dart';

class DetailNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi Cuti/Izin'),
         backgroundColor: Colors.grey[300],
        centerTitle: true,
        elevation: 0,leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Kembali ke halaman profil
          },
        ),
      ),  
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF001F54),
              Color(0xFF003566),
              Color(0xFF006494),
              Color(0xFF669BBC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color.fromARGB(255, 83, 203, 123),
                  size: 50,
                ),
                SizedBox(height: 16),
                Text(
                  'Permohonan Cuti Disetujui',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:Color(0xFF003566),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hi Agus Sedih, Kami informasikan bahwa permohonan cuti Anda untuk tanggal 10-12 Oktober 2024 telah disetujui.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Action when the OK button is pressed
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF003566),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(137, 255, 255, 255),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetailNotification(),
  ));
}
