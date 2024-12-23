import 'dart:developer';

import 'package:dio/dio.dart';


class PresenceService {
  final Dio dio;

  PresenceService({required String baseUrl})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
           connectTimeout: Duration(milliseconds: 5000), 
          receiveTimeout: Duration(milliseconds: 3000), 
        ));

  /// Fetch attendances
  Future<Map<String, dynamic>> fetchAttendances() async {
    try {
      final response = await dio.get('/api/history');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          return {'success': true, 'data': data['data']};
        } else {
          return {'success': false, 'message': 'Failed to fetch data.'};
        }
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.statusCode}, ${response.statusMessage}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createAttendance({
    required String title,
    required String description,
    required String startTime,
    required String batasStartTime,
    required String endTime,
    required String batasEndTime,
  }) async {
    try {
      final response = await dio.post(
        '/api/history', 
        data: {
          'title': title,
          'description': description,
          'start_time': startTime,
          'batas_start_time': batasStartTime,
          'end_time': endTime,
          'batas_end_time': batasEndTime,
        },
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data berhasil ditambahkan',
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': 'Terjadi kesalahan pada server',
          'data': null,
        };
      }
    } on DioError catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Terjadi kesalahan',
        'data': null,
      };
    }
  }
}
