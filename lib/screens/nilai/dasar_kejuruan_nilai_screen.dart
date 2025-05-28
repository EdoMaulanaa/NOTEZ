import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/grade_data.dart';
import '../../widgets/loading_widget.dart';
import 'dasar_kejuruan/bu_diyah_nilai_screen.dart';
import 'dasar_kejuruan/pak_dhanang_nilai_screen.dart';
import 'dasar_kejuruan/pak_mahmudi_nilai_screen.dart';
import 'dasar_kejuruan/pjbl_nilai_screen.dart';

class DasarKejuruanNilaiScreen extends StatefulWidget {
  const DasarKejuruanNilaiScreen({super.key});

  @override
  State<DasarKejuruanNilaiScreen> createState() =>
      _DasarKejuruanNilaiScreenState();
}

class _DasarKejuruanNilaiScreenState extends State<DasarKejuruanNilaiScreen> {
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
        title: Text(
          'Dasar Kejuruan',
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

          final grades = snapshot.data!;
          final dasarKejuruanGrades = grades.subjects['Dasar Kejuruan'];
          final buDiyahAvg = grades.dasarKejuruanSub['Bu Diyah']?.calculateSubjectAverage() ?? 0.0;
          final pakDhanangAvg = grades.dasarKejuruanSub['Pak Dhanang']?.calculateSubjectAverage() ?? 0.0;
          final pakMahmudiAvg = grades.dasarKejuruanSub['Pak Mahmudi']?.calculateSubjectAverage() ?? 0.0;
          final pjblAvg = grades.dasarKejuruanSub['PJBL']?.calculateSubjectAverage() ?? 0.0;
          final overallAvg = dasarKejuruanGrades != null ? 
              dasarKejuruanGrades.calculateSubjectAverage() : 
              ((buDiyahAvg + pakDhanangAvg + pakMahmudiAvg + pjblAvg) / 4);
          
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07,
                top: 20,
                bottom: 80,
              ),
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
                          overallAvg.toStringAsFixed(1),
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
                            _buildValueItem(
                              label: 'Bu Diyah',
                              value: buDiyahAvg,
                              color: Colors.blue,
                            ),
                            _buildValueItem(
                              label: 'Pak Dhanang',
                              value: pakDhanangAvg,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildValueItem(
                              label: 'Pak Mahmudi',
                              value: pakMahmudiAvg,
                              color: Colors.orange,
                            ),
                            _buildValueItem(
                              label: 'PJBL',
                              value: pjblAvg,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  
                  Text(
                    'Pengajar',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    children: [
                      _buildMenuItem(
                        title: 'Bu Diyah',
                        subtitle: '4 penilaian per semester',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BuDiyahNilaiScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        title: 'Pak Dhanang',
                        subtitle: '4 penilaian per semester',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PakDhanangNilaiScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        title: 'Pak Mahmudi',
                        subtitle: '4 penilaian per semester',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PakMahmudiNilaiScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        title: 'PJBL',
                        subtitle: '2 penilaian per semester',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PjblNilaiScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildMenuItem({
    required String title,
    required String subtitle,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
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
  
  Widget _buildValueItem({
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
