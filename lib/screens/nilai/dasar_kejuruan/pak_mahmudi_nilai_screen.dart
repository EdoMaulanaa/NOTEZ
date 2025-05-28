import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/grade_data.dart';
import '../../../widgets/loading_widget.dart';

class PakMahmudiNilaiScreen extends StatefulWidget {
  const PakMahmudiNilaiScreen({super.key});

  @override
  State<PakMahmudiNilaiScreen> createState() => _PakMahmudiNilaiScreenState();
}

class _PakMahmudiNilaiScreenState extends State<PakMahmudiNilaiScreen> {
  late Future<AllGrades> _gradesFuture;

  @override
  void initState() {
    super.initState();
    _gradesFuture = GradeManager().getGradesAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pak Mahmudi - Dasar Kejuruan',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<AllGrades>(
        future: _gradesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(
              message: 'Memuat data nilai...',
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            );
          }

          final pakMahmudiGrades = snapshot.data!.dasarKejuruanSub['Pak Mahmudi'];
          if (pakMahmudiGrades == null) {
            return Center(
              child: Text(
                'Data nilai tidak ditemukan',
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                if (pakMahmudiGrades.semesters['semester1'] != null)
                  _buildGradeCard(
                    'Semester 1',
                    pakMahmudiGrades.semesters['semester1']!.dailyGrades.take(4).toList(),
                    pakMahmudiGrades.semesters['semester1']!.examGrade,
                  ),

                
                if (pakMahmudiGrades.semesters['semester2'] != null)
                  _buildGradeCard(
                    'Semester 2',
                    pakMahmudiGrades.semesters['semester2']!.dailyGrades.take(4).toList(),
                    pakMahmudiGrades.semesters['semester2']!.examGrade,
                  ),

                
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rata-rata Keseluruhan',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        pakMahmudiGrades.calculateSubjectAverage().toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradeCard(String title, List<double> grades, double? examGrade) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGradeSection('Nilai Harian', grades),
                if (examGrade != null) ...[
                  const SizedBox(height: 16),
                  _buildGradeSection('Nilai Ujian', [examGrade]),
                ],
                const SizedBox(height: 16),
                _buildAverageSection(grades, examGrade),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeSection(String title, List<double> grades) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: grades.asMap().entries.map((entry) {
            final index = entry.key;
            final grade = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title == 'Nilai Ujian' 
                    ? 'Ujian: ${grade.toStringAsFixed(1)}'
                    : 'Harian ${index + 1}: ${grade.toStringAsFixed(1)}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAverageSection(List<double> grades, double? examGrade) {
    double average = 0;
    int count = grades.length;
    double sum = grades.reduce((a, b) => a + b);
    
    if (examGrade != null) {
      sum += examGrade;
      count++;
    }
    
    average = sum / count;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rata-rata',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            average.toStringAsFixed(1),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
