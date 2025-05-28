import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AttendanceRecord {
  final String date;
  final String type; 
  final String? note;

  AttendanceRecord({
    required this.date,
    required this.type,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'type': type,
      'note': note,
    };
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      date: json['date'],
      type: json['type'],
      note: json['note'],
    );
  }
}

class AttendanceData {
  final List<AttendanceRecord> records;

  AttendanceData({required this.records});

  Map<String, dynamic> toJson() {
    return {
      'records': records.map((record) => record.toJson()).toList(),
    };
  }

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      records: (json['records'] as List)
          .map((record) => AttendanceRecord.fromJson(record))
          .toList(),
    );
  }

  int get totalAlpha {
    return records.where((record) => record.type == 'alpha').length;
  }

  int get totalIzin {
    return records.where((record) => record.type == 'izin').length;
  }

  int get totalSakit {
    return records.where((record) => record.type == 'sakit').length;
  }
}


class AttendanceManager {
  static final AttendanceManager _instance = AttendanceManager._internal();
  factory AttendanceManager() => _instance;
  AttendanceManager._internal();

  late AttendanceData _attendance;
  bool _isInitialized = false;

  
  AttendanceData get attendance {
    if (!_isInitialized) {
      _initializeAttendance();
    }
    return _attendance;
  }

  
  void _initializeAttendance() {
    _attendance = AttendanceData(records: [
      AttendanceRecord(
        date: '2024-05-22',
        type: 'alpha',
        note: 'Tidak ada keterangan',
      ),
      AttendanceRecord(
        date: '2024-05-15',
        type: 'sakit',
        note: 'Demam',
      ),
      AttendanceRecord(
        date: '2024-05-08',
        type: 'izin',
        note: 'Acara keluarga',
      ),
      AttendanceRecord(
        date: '2024-04-25',
        type: 'alpha',
        note: 'Tidak ada keterangan',
      ),
      AttendanceRecord(
        date: '2024-04-18',
        type: 'sakit',
        note: 'Sakit perut',
      ),
      AttendanceRecord(
        date: '2024-04-10',
        type: 'izin',
        note: 'Ke dokter',
      ),
      AttendanceRecord(
        date: '2024-04-03',
        type: 'alpha',
        note: 'Tidak ada keterangan',
      ),
    ]);

    _isInitialized = true;
  }
}


Future<AttendanceData> readAttendance() async {
  try {
    
    return AttendanceManager().attendance;
  } catch (e) {
    print('Error reading attendance: $e');
    
    return AttendanceManager().attendance;
  }
}


Future<void> writeAttendance(AttendanceData attendance) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/attendance.json');
    await file.writeAsString(json.encode(attendance.toJson()));
  } catch (e) {
    print('Error writing attendance: $e');
  }
}
