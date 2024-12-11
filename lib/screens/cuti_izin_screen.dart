import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'detail_notification.dart';

class CutiIzinScreen extends StatefulWidget {
  const CutiIzinScreen({super.key});

  @override
  _CutiIzinScreenState createState() => _CutiIzinScreenState();
}

class _CutiIzinScreenState extends State<CutiIzinScreen> {
  FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final TextEditingController _keteranganController = TextEditingController();
  DateTime? _tanggalMulai;
  DateTime? _tanggalSelesai;

  void _kirimFormulir() {
    if (_keteranganController.text.isNotEmpty &&
        _tanggalMulai != null &&
        _tanggalSelesai != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengajuan Cuti/Izin Berhasil!')),
      );

      _showNotification(
        'Pengajuan Diterima',
        'Pengajuan cuti Anda telah berhasil. Klik untuk detail.',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon lengkapi semua data!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _navigateToDetail(response.payload!);
        }
      },
    );
  }

  void _navigateToDetail(String payload) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailNotification()),
    );
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'status_channel',
      'Status Cuti',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'detail_notifikasi', // Payload yang akan diproses
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Cuti/Izin'),
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Bagian Profil
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
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
                          'Hi, Agus',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          'Karyawan',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _keteranganController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  labelStyle: TextStyle(color: Colors.white),
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
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _tanggalMulai == null
                          ? 'Mulai'
                          : 'Mulai: ${_tanggalMulai!.toLocal()}'.split(' ')[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _tanggalMulai) {
                        setState(() {
                          _tanggalMulai = picked;
                        });
                      }
                    },
                    child: Text('Pilih Tanggal Mulai'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _tanggalSelesai == null
                          ? 'Selesai'
                          : 'Selesai: ${_tanggalSelesai!.toLocal()}'
                              .split(' ')[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _tanggalSelesai) {
                        setState(() {
                          _tanggalSelesai = picked;
                        });
                      }
                    },
                    child: Text('Pilih Tanggal Selesai'),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: _kirimFormulir,
                child: Text('Ajukan Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
