import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/grade_data.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/grade_card.dart';

class InformatikaNilaiScreen extends StatefulWidget {
  const InformatikaNilaiScreen({super.key});

  @override
  State<InformatikaNilaiScreen> createState() => _InformatikaNilaiScreenState();
}

class _InformatikaNilaiScreenState extends State<InformatikaNilaiScreen> {
  late Future<AllGrades> _gradesFuture;

  @override
  void initState() {
    super.initState();
    _gradesFuture = GradeManager().getGradesAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Informatika',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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

          final informatikaGrades = snapshot.data!.subjects['Informatika'];
          if (informatikaGrades == null) {
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
                
                if (informatikaGrades.semesters['semester1'] != null)
                  GradeCard(
                    title: 'Semester 1',
                    grades:
                        informatikaGrades.semesters['semester1']!.dailyGrades,
                    examGrade:
                        informatikaGrades.semesters['semester1']!.examGrade,
                  ),

                
                if (informatikaGrades.semesters['semester2'] != null)
                  GradeCard(
                    title: 'Semester 2',
                    grades:
                        informatikaGrades.semesters['semester2']!.dailyGrades,
                    examGrade:
                        informatikaGrades.semesters['semester2']!.examGrade,
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
                          color: const Color(0xFF6C63FF),
                        ),
                      ),
                      Text(
                        informatikaGrades
                            .calculateSubjectAverage()
                            .toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF6C63FF),
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
}
