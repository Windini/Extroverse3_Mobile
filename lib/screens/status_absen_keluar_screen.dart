import 'package:flutter/material.dart';

class StatusAbsenKeluarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Absen Keluar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Absen Keluar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(height: 16),
            AbsenStatusCard(
              date: '26 September 2024',
              time: '17:00',
              location: 'Sindang, Indramayu',
            ),
            SizedBox(height: 16),
            AbsenStatusCard(
              date: '26 September 2024',
              time: '17:30',
              location: 'Sindang, Indramayu',
            ),
          ],
        ),
      ),
    );
  }
}

class AbsenStatusCard extends StatelessWidget {
  final String date;
  final String time;
  final String location;

  const AbsenStatusCard({
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.red),
              SizedBox(width: 8),
              Text('Anda Keluar pukul $time'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 8),
              Text('Alamat : $location'),
            ],
          ),
        ],
      ),
    );
  }
}
