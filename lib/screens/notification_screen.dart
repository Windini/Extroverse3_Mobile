import 'package:flutter/material.dart';
import 'detail_notification.dart';

class NotificationScreen extends StatelessWidget {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 1,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      'E',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    'Extrovers',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Persetujuan Permohonan Cuti Hi Agus Sedih,', 
                    style: TextStyle(color: Colors.black54),
                  ),
                  onTap: () {
                    // Navigate to DetailNotification
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailNotification()),
                    );
                  },
                ),
              ),
              // Footer removed
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationScreen(),
  ));
}
