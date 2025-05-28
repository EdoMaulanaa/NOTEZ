import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PointRecord {
  final String date;
  final String description;
  final int points;
  final String type; 

  PointRecord({
    required this.date,
    required this.description,
    required this.points,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'points': points,
      'type': type,
    };
  }

  factory PointRecord.fromJson(Map<String, dynamic> json) {
    return PointRecord(
      date: json['date'],
      description: json['description'],
      points: json['points'],
      type: json['type'],
    );
  }
}

class PointData {
  final List<PointRecord> records;

  PointData({required this.records});

  Map<String, dynamic> toJson() {
    return {
      'records': records.map((record) => record.toJson()).toList(),
    };
  }

  factory PointData.fromJson(Map<String, dynamic> json) {
    return PointData(
      records: (json['records'] as List)
          .map((record) => PointRecord.fromJson(record))
          .toList(),
    );
  }

  int get totalPoints {
    int pelanggaranPoints = records
        .where((record) => record.type == 'pelanggaran')
        .fold(0, (sum, record) => sum + record.points);
    int prestasiPoints = records
        .where((record) => record.type == 'prestasi')
        .fold(0, (sum, record) => sum + record.points);
    return prestasiPoints - pelanggaranPoints;
  }

  int get totalPelanggaranPoints {
    return records
        .where((record) => record.type == 'pelanggaran')
        .fold(0, (sum, record) => sum + record.points);
  }

  int get totalPrestasiPoints {
    return records
        .where((record) => record.type == 'prestasi')
        .fold(0, (sum, record) => sum + record.points);
  }
}


class PointManager {
  static final PointManager _instance = PointManager._internal();
  factory PointManager() => _instance;
  PointManager._internal();

  late PointData _points;
  bool _isInitialized = false;

  
  PointData get points {
    if (!_isInitialized) {
      _initializePoints();
    }
    return _points;
  }

  
  void _initializePoints() {
    _points = PointData(records: [
      
      PointRecord(
        date: '2024-05-20',
        description: 'Terlambat masuk kelas 15 menit',
        points: 2,
        type: 'pelanggaran',
      ),
      PointRecord(
        date: '2024-05-15',
        description: 'Tidak mengerjakan PR Matematika',
        points: 5,
        type: 'pelanggaran',
      ),
      PointRecord(
        date: '2024-05-08',
        description: 'Tidak memakai atribut lengkap',
        points: 3,
        type: 'pelanggaran',
      ),
      PointRecord(
        date: '2024-04-25',
        description: 'Bermain handphone saat pelajaran',
        points: 5,
        type: 'pelanggaran',
      ),
      PointRecord(
        date: '2024-04-17',
        description: 'Tidak mengikuti upacara',
        points: 7,
        type: 'pelanggaran',
      ),
      PointRecord(
        date: '2024-04-10',
        description: 'Membuat keributan di kelas',
        points: 4,
        type: 'pelanggaran',
      ),
      PointRecord(
        date: '2024-04-03',
        description: 'Tidak membawa buku pelajaran',
        points: 2,
        type: 'pelanggaran',
      ),

      
      PointRecord(
        date: '2024-05-22',
        description: 'Membantu guru membersihkan perpustakaan',
        points: 3,
        type: 'prestasi',
      ),
      PointRecord(
        date: '2024-05-18',
        description: 'Juara 2 Lomba Debat Bahasa Inggris',
        points: 10,
        type: 'prestasi',
      ),
      PointRecord(
        date: '2024-05-10',
        description: 'Berpartisipasi dalam kegiatan ekstrakurikuler',
        points: 2,
        type: 'prestasi',
      ),
      PointRecord(
        date: '2024-04-28',
        description: 'Menjadi petugas upacara',
        points: 5,
        type: 'prestasi',
      ),
      PointRecord(
        date: '2024-04-20',
        description: 'Juara 1 Olimpiade Matematika Tingkat Kota',
        points: 15,
        type: 'prestasi',
      ),
      PointRecord(
        date: '2024-04-12',
        description: 'Menyelesaikan tugas tepat waktu selama seminggu',
        points: 3,
        type: 'prestasi',
      ),
      PointRecord(
        date: '2024-03-30',
        description: 'Mewakili sekolah dalam kompetisi coding',
        points: 7,
        type: 'prestasi',
      ),
    ]);

    _isInitialized = true;
  }
}

Future<PointData> readPoints() async {
  try {
    
    return PointManager().points;
  } catch (e) {
    print('Error reading points: $e');
    
    return PointManager().points;
  }
}

Future<void> writePoints(PointData points) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/points.json');
    await file.writeAsString(json.encode(points.toJson()));
  } catch (e) {
    print('Error writing points: $e');
  }
}
