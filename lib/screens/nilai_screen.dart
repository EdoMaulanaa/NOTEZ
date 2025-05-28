import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/grade_data.dart';
import '../widgets/report_button.dart';
import 'nilai/dasar_kejuruan_nilai_screen.dart';
import 'nilai/matematika_nilai_screen.dart';
import 'nilai/bahasa_indonesia_nilai_screen.dart';
import 'nilai/bahasa_inggris_nilai_screen.dart';
import 'nilai/bahasa_jawa_nilai_screen.dart';
import 'nilai/seni_budaya_nilai_screen.dart';
import 'nilai/informatika_nilai_screen.dart';
import 'nilai/sejarah_nilai_screen.dart';
import 'nilai/pendidikan_pancasila_nilai_screen.dart';
import 'nilai/pendidikan_agama_nilai_screen.dart';
import 'nilai/pjok_nilai_screen.dart';

class NilaiScreen extends StatelessWidget {
  const NilaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final grades = GradeManager().grades;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Nilai',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ReportButton(screenName: 'Nilai'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.07,
              right: MediaQuery.of(context).size.width * 0.07,
              top: 20,
              bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Rata-Rata Nilai',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      grades != null
                          ? grades.calculateOverallAverage().toStringAsFixed(1)
                          : '0.0',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNilaiItem(
                          label: 'Semester 1',
                          value: _calculateSemesterAverage(grades, 'semester1'),
                          color: Colors.blue,
                        ),
                        _buildNilaiItem(
                          label: 'Semester 2',
                          value: _calculateSemesterAverage(grades, 'semester2'),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 0, bottom: 60 + 10 + 10),
                children: [
                  _buildMenuItem(
                      title: 'Dasar - Dasar Kejuruan',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DasarKejuruanNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Matematika',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MatematikaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Bahasa Indonesia',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BahasaIndonesiaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Bahasa Inggris',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BahasaInggrisNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Bahasa Jawa',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BahasaJawaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Seni Budaya',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SeniBudayaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Informatika',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InformatikaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Sejarah',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SejarahNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Pendidikan Pancasila',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PendidikanPancasilaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'Pendidikan Agama',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PendidikanAgamaNilaiScreen()));
                      }),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                      title: 'PJOK',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PJOKNilaiScreen()));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
    double height = 72,
    double radius = 20,
    double titleSize = 15,
    double fontSize = 14,
    double cardPadding = 20,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: cardPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: titleSize,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateSemesterAverage(AllGrades? grades, String semester) {
    if (grades == null) return 0.0;
    
    double totalSemesterAverage = 0.0;
    int subjectCount = 0;
    
    
    grades.subjects.forEach((subject, data) {
      if (data.semesters.containsKey(semester)) {
        totalSemesterAverage += data.semesters[semester]!.calculateSemesterAverage();
        subjectCount++;
      }
    });
    
    
    grades.dasarKejuruanSub.forEach((subject, data) {
      if (data.semesters.containsKey(semester)) {
        totalSemesterAverage += data.semesters[semester]!.calculateSemesterAverage();
        subjectCount++;
      }
    });
    
    return subjectCount > 0 ? totalSemesterAverage / subjectCount : 0.0;
  }

  Widget _buildNilaiItem({
    required String label,
    required double value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toStringAsFixed(1),
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
