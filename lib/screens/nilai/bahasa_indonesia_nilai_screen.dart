import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/grade_data.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/grade_card.dart';
import '../../widgets/decorative_background.dart';
import '../../widgets/decorative_header.dart';

class BahasaIndonesiaNilaiScreen extends StatefulWidget {
  const BahasaIndonesiaNilaiScreen({super.key});

  @override
  State<BahasaIndonesiaNilaiScreen> createState() =>
      _BahasaIndonesiaNilaiScreenState();
}

class _BahasaIndonesiaNilaiScreenState
    extends State<BahasaIndonesiaNilaiScreen> {
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
          'Bahasa Indonesia',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: DecorativeBackground(
        child: FutureBuilder<AllGrades>(
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

            final bahasaIndonesiaGrades =
                snapshot.data!.subjects['Bahasa Indonesia'];
            if (bahasaIndonesiaGrades == null) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DecorativeHeader(
                    title: 'Nilai Bahasa Indonesia',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        if (bahasaIndonesiaGrades.semesters['semester1'] !=
                            null)
                          GradeCard(
                            title: 'Semester 1',
                            grades: bahasaIndonesiaGrades
                                .semesters['semester1']!.dailyGrades,
                            examGrade: bahasaIndonesiaGrades
                                .semesters['semester1']!.examGrade,
                          ),

                        
                        if (bahasaIndonesiaGrades.semesters['semester2'] !=
                            null)
                          GradeCard(
                            title: 'Semester 2',
                            grades: bahasaIndonesiaGrades
                                .semesters['semester2']!.dailyGrades,
                            examGrade: bahasaIndonesiaGrades
                                .semesters['semester2']!.examGrade,
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
                                bahasaIndonesiaGrades
                                    .calculateSubjectAverage()
                                    .toStringAsFixed(1),
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
