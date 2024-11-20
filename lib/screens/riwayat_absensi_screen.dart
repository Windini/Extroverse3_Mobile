import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiwayatAbsensiScreen(),
    );
  }
}

class RiwayatAbsensiScreen extends StatelessWidget {
  const RiwayatAbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Absensi'),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
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
        child: AttendanceHistoryPage(),
      ),
    );
  }
}

class AttendanceHistoryPage extends StatelessWidget {
  final List<AttendanceRecord> attendanceRecords = [
    AttendanceRecord(date: "26 September 2024", checkIn: "07:04", checkOut: "15:00", location: "Sindang, Indramayu"),
    AttendanceRecord(date: "27 September 2024", checkIn: "07:04", checkOut: "15:04", location: "Sindang, Indramayu"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: attendanceRecords.length,
      itemBuilder: (context, index) {
        return AttendanceCard(record: attendanceRecords[index]);
      },
    );
  }
}

class AttendanceRecord {
  final String date;
  final String checkIn;
  final String checkOut;
  final String location;

  AttendanceRecord({
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.location,
  });
}

class AttendanceCard extends StatelessWidget {
  final AttendanceRecord record;

  const AttendanceCard({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tanggal
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            margin: EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              record.date,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        // Card riwayat absensi masuk
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.fingerprint, color: Colors.green),
                  SizedBox(width: 8),
                  Text("Anda Masuk pukul ${record.checkIn}"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Lokasi : ${record.location}"),
                ],
              ),
            ],
          ),
        ),

        // Card riwayat absensi keluar
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.fingerprint, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Anda Keluar pukul ${record.checkOut}"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Lokasi : ${record.location}"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
