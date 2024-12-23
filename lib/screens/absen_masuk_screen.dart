import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import '../service/Presence_service.dart';

class MapWithRadiusScreen extends StatefulWidget {
  @override
  _MapWithRadiusScreenState createState() => _MapWithRadiusScreenState();
}

class _MapWithRadiusScreenState extends State<MapWithRadiusScreen> {
  late GoogleMapController _mapController;
  static const LatLng _center = LatLng(-6.40801, 108.28146);
  static const double _radiusInMeters = 600;

  Set<Circle> _circles = {
    Circle(
      circleId: CircleId("center_circle"),
      center: _center,
      radius: _radiusInMeters,
      fillColor: Colors.blue.withOpacity(0.3),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    ),
  };

  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("center_marker"),
      position: _center,
      infoWindow: InfoWindow(title: "Lokasi Pusat"),
    ),
  };

  final PresenceService _apiService = PresenceService(baseUrl: 'http://172.20.10.3:8000');

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _findUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Layanan lokasi tidak aktif.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin lokasi ditolak.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin lokasi ditolak secara permanen.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng userLocation = LatLng(position.latitude, position.longitude);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("user_marker"),
          position: userLocation,
          infoWindow: InfoWindow(title: "Lokasi Anda"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });

    _mapController.animateCamera(CameraUpdate.newLatLngZoom(userLocation, 14));
  }

  bool _isWithinRadius(LatLng point1, LatLng point2, double radius) {
    const double earthRadius = 6371000; // in meters
    double latDiff = _degreesToRadians(point2.latitude - point1.latitude);
    double lngDiff = _degreesToRadians(point2.longitude - point1.longitude);

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(_degreesToRadians(point1.latitude)) *
            cos(_degreesToRadians(point2.latitude)) *
            sin(lngDiff / 2) *
            sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c <= radius;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

void _performCheckIn() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng userLocation = LatLng(position.latitude, position.longitude);
    bool isInsideRadius = _isWithinRadius(userLocation, _center, _radiusInMeters);

    if (isInsideRadius) {
      Map<String, dynamic> result = await _apiService.createAttendance(
        title: 'Absen Masuk',
        description: 'Absen Masuk berdasarkan lokasi',
        startTime: DateTime.now().toIso8601String(),
        batasStartTime: DateTime.now().add(Duration(minutes: 10)).toIso8601String(),
        endTime: DateTime.now().add(Duration(minutes: 30)).toIso8601String(),
        batasEndTime: DateTime.now().add(Duration(minutes: 35)).toIso8601String(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message'],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Anda berada di luar radius absen.'),
        ),
      );
    }
    print('User Location: $userLocation');
    print('Is Inside Radius: $isInsideRadius');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absen Masuk'),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        elevation: 0,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                        'Hi, Agus',  // Update nama sesuai dengan nama karyawan
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        'Karyawan',  // Update peran sesuai dengan peran karyawan
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14,
                ),
                markers: _markers,
                circles: _circles,
                myLocationEnabled: true,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _findUserLocation,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.my_location,
                    color: Color(0xFF003566),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Temukan Lokasi',
                    style: TextStyle(
                      color: Color(0xFF003566),
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performCheckIn,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF003566),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Absen',
                    style: TextStyle(
                      color: Color(0xFF003566),
                      fontSize: 16.0,
                    ),
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