import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';


class SemesterGrades {
  List<double> dailyGrades = List.filled(8, 0.0);
  double? examGrade;
  List<double> pjblGrades = []; 

  SemesterGrades();

  factory SemesterGrades.fromJson(Map<String, dynamic> json) {
    return SemesterGrades()
      ..dailyGrades =
          List<double>.from(json['dailyGrades'] ?? List.filled(8, 0.0))
      ..examGrade = json['examGrade']
      ..pjblGrades = List<double>.from(json['pjblGrades'] ?? []);
  }

  Map<String, dynamic> toJson() => {
        'dailyGrades': dailyGrades,
        'examGrade': examGrade,
        'pjblGrades': pjblGrades,
      };

  
  double calculateSemesterAverage() {
    if (dailyGrades.isEmpty && examGrade == null && pjblGrades.isEmpty)
      return 0.0;

    double total = 0;
    int count = 0;

    
    if (dailyGrades.isNotEmpty) {
      total += dailyGrades.reduce((a, b) => a + b);
      count += dailyGrades.length;
    }

    
    if (examGrade != null) {
      total += examGrade!;
      count += 1;
    }

    
    if (pjblGrades.isNotEmpty) {
      total += pjblGrades.reduce((a, b) => a + b);
      count += pjblGrades.length;
    }

    return count > 0 ? total / count : 0.0;
  }
}


class SubjectGrades {
  Map<String, SemesterGrades> semesters = {}; 

  SubjectGrades();

  factory SubjectGrades.fromJson(Map<String, dynamic> json) {
    return SubjectGrades()
      ..semesters = (json['semesters'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, SemesterGrades.fromJson(value)),
          ) ??
          {};
  }

  Map<String, dynamic> toJson() => {
        'semesters':
            semesters.map((key, value) => MapEntry(key, value.toJson())),
      };

  
  double calculateSubjectAverage() {
    if (semesters.isEmpty) return 0.0;

    double totalSemesterAverage = 0;
    int semesterCount = 0;

    semesters.forEach((key, semester) {
      totalSemesterAverage += semester.calculateSemesterAverage();
      semesterCount++;
    });

    return semesterCount > 0 ? totalSemesterAverage / semesterCount : 0.0;
  }
}


class AllGrades {
  Map<String, SubjectGrades> subjects = {}; 
  
  Map<String, SubjectGrades> dasarKejuruanSub =
      {}; 

  AllGrades();

  factory AllGrades.fromJson(Map<String, dynamic> json) {
    return AllGrades()
      ..subjects = (json['subjects'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, SubjectGrades.fromJson(value)),
          ) ??
          {}
      
      ..dasarKejuruanSub =
          (json['dasarKejuruanSub'] as Map<String, dynamic>?)?.map(
                (key, value) => MapEntry(key, SubjectGrades.fromJson(value)),
              ) ??
              {};
  }

  Map<String, dynamic> toJson() => {
        'subjects': subjects.map((key, value) => MapEntry(key, value.toJson())),
        
        'dasarKejuruanSub':
            dasarKejuruanSub.map((key, value) => MapEntry(key, value.toJson())),
      };

  
  double calculateOverallAverage() {
    double totalSubjectAverage = 0;
    int subjectCount = 0;

    
    subjects.forEach((key, subject) {
      totalSubjectAverage += subject.calculateSubjectAverage();
      subjectCount++;
    });

    
    dasarKejuruanSub.forEach((key, subject) {
      totalSubjectAverage += subject.calculateSubjectAverage();
      subjectCount++;
    });

    return subjectCount > 0 ? totalSubjectAverage / subjectCount : 0.0;
  }
}


class GradeManager {
  static final GradeManager _instance = GradeManager._internal();
  factory GradeManager() => _instance;
  GradeManager._internal();

  late AllGrades _grades;
  bool _isInitialized = false;

  
  AllGrades get grades {
    if (!_isInitialized) {
      _initializeGrades();
    }
    return _grades;
  }

  
  Future<AllGrades> getGradesAsync() async {
    if (!_isInitialized) {
      _initializeGrades();
    }
    return _grades;
  }

  
  void _initializeGrades() {
    _grades = AllGrades();

    
    _grades.subjects['Matematika'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [80.0, 85.0, 90.0, 75.0, 88.0, 92.0, 78.0, 85.0]
        ..examGrade = 87.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [82.0, 88.0, 85.0, 90.0, 86.0, 89.0, 84.0, 87.0]
        ..examGrade = 88.0);

    
    _grades.subjects['Bahasa Indonesia'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [78.0, 82.0, 85.0, 88.0, 79.0, 81.0, 84.0, 86.0]
        ..examGrade = 83.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [80.0, 84.0, 87.0, 85.0, 82.0, 86.0, 83.0, 88.0]
        ..examGrade = 85.0);

    
    _grades.subjects['Bahasa Inggris'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [85.0, 88.0, 90.0, 82.0, 86.0, 89.0, 91.0, 93.0]
        ..examGrade = 90.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [87.0, 90.0, 92.0, 89.0, 91.0, 94.0, 88.0, 93.0]
        ..examGrade = 92.0);

    
    _grades.subjects['Bahasa Jawa'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [80.0, 82.0, 85.0, 78.0, 81.0, 84.0, 86.0, 79.0]
        ..examGrade = 85.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [82.0, 85.0, 88.0, 84.0, 87.0, 90.0, 83.0, 86.0]
        ..examGrade = 87.0);

    
    _grades.subjects['Seni Budaya'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [85.0, 88.0, 90.0, 87.0, 89.0, 91.0, 86.0, 88.0]
        ..examGrade = 89.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [87.0, 90.0, 88.0, 92.0, 89.0, 91.0, 88.0, 90.0]
        ..examGrade = 90.0);

    
    _grades.subjects['Informatika'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [90.0, 92.0, 95.0, 91.0, 93.0, 94.0, 90.0, 92.0]
        ..examGrade = 93.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [92.0, 94.0, 96.0, 93.0, 95.0, 97.0, 91.0, 94.0]
        ..examGrade = 95.0);

    
    _grades.subjects['Sejarah'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [80.0, 83.0, 85.0, 77.0, 81.0, 84.0, 86.0, 78.0]
        ..examGrade = 85.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [82.0, 85.0, 87.0, 84.0, 86.0, 89.0, 83.0, 87.0]
        ..examGrade = 86.0);

    
    _grades.subjects['Pendidikan Pancasila'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [85.0, 88.0, 90.0, 82.0, 86.0, 89.0, 81.0, 83.0]
        ..examGrade = 90.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [87.0, 90.0, 92.0, 89.0, 91.0, 94.0, 88.0, 93.0]
        ..examGrade = 92.0);

    
    _grades.subjects['Pendidikan Agama'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [90.0, 93.0, 95.0, 87.0, 91.0, 94.0, 86.0, 88.0]
        ..examGrade = 95.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [92.0, 95.0, 97.0, 89.0, 93.0, 96.0, 90.0, 94.0]
        ..examGrade = 97.0);

    
    _grades.subjects['PJOK'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [90.0, 92.0, 95.0, 91.0, 93.0, 94.0, 90.0, 92.0]
        ..examGrade = 93.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [92.0, 94.0, 96.0, 93.0, 95.0, 97.0, 91.0, 94.0]
        ..examGrade = 95.0);

    
    _grades.dasarKejuruanSub['Bu Diyah'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [85.0, 88.0, 90.0, 87.0, 89.0, 91.0, 86.0, 88.0]
        ..examGrade = 89.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [87.0, 90.0, 88.0, 92.0, 89.0, 91.0, 88.0, 90.0]
        ..examGrade = 90.0);

    _grades.dasarKejuruanSub['Pak Dhanang'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [88.0, 90.0, 92.0, 85.0, 87.0, 89.0, 86.0, 88.0]
        ..examGrade = 90.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [90.0, 92.0, 94.0, 87.0, 89.0, 91.0, 88.0, 90.0]
        ..examGrade = 92.0);

    _grades.dasarKejuruanSub['Pak Mahmudi'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [87.0, 89.0, 91.0, 84.0, 86.0, 88.0, 85.0, 87.0]
        ..examGrade = 88.0)
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [89.0, 91.0, 93.0, 86.0, 88.0, 90.0, 87.0, 89.0]
        ..examGrade = 90.0);

    _grades.dasarKejuruanSub['PJBL'] = SubjectGrades()
      ..semesters['semester1'] = (SemesterGrades()
        ..dailyGrades = [90.0, 92.0, 94.0, 87.0, 89.0, 91.0, 88.0, 90.0]
        ..examGrade = 92.0
        ..pjblGrades = [93.0, 95.0])
      ..semesters['semester2'] = (SemesterGrades()
        ..dailyGrades = [92.0, 94.0, 96.0, 89.0, 91.0, 93.0, 90.0, 92.0]
        ..examGrade = 94.0
        ..pjblGrades = [95.0, 97.0]);

    _isInitialized = true;
  }
}


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}


Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/grades.json');
}


Future<AllGrades> readGrades() async {
  try {
    
    
    return GradeManager().grades;
  } catch (e) {
    print('Error reading grades: $e');
    
    return GradeManager().grades;
  }
}


Future<File> writeGrades(AllGrades grades) async {
  final file = await _localFile;
  
  return file.writeAsString(jsonEncode(grades.toJson()));
}
