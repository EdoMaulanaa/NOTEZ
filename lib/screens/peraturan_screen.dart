import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/report_button.dart';
import 'peraturan/peraturan_detail_screen.dart';

class PeraturanScreen extends StatelessWidget {
  const PeraturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Peraturan',
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
            child: ReportButton(screenName: 'Peraturan'),
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
              
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                children: [
                  _buildPeraturanItem(
                    title: 'Tata Tertib Umum',
                    subtitle: 'Peraturan dasar yang berlaku di sekolah',
                    icon: Icons.gavel_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PeraturanDetailScreen(
                            title: 'Tata Tertib Umum',
                            rules: [
                              'Siswa wajib hadir di sekolah 15 menit sebelum bel masuk berbunyi.',
                              'Siswa wajib mengikuti upacara bendera setiap hari Senin.',
                              'Siswa wajib mengenakan seragam sesuai ketentuan yang berlaku.',
                              'Siswa wajib menjaga kebersihan dan kerapian lingkungan sekolah.',
                              'Siswa wajib menghormati guru dan karyawan sekolah.',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPeraturanItem(
                    title: 'Tata Tertib Akademik',
                    subtitle: 'Peraturan terkait kegiatan belajar mengajar',
                    icon: Icons.school_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PeraturanDetailScreen(
                            title: 'Tata Tertib Akademik',
                            rules: [
                              'Siswa wajib mengikuti semua kegiatan pembelajaran.',
                              'Siswa wajib mengerjakan tugas yang diberikan guru.',
                              'Siswa wajib membawa buku dan alat tulis yang diperlukan.',
                              'Siswa wajib mengikuti ulangan dan ujian sesuai jadwal.',
                              'Siswa wajib menjaga ketenangan saat proses pembelajaran.',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPeraturanItem(
                    title: 'Tata Tertib Seragam',
                    subtitle: 'Peraturan penggunaan seragam sekolah',
                    icon: Icons.checkroom_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PeraturanDetailScreen(
                            title: 'Tata Tertib Seragam',
                            rules: [
                              'Senin: Seragam Putih Abu-abu',
                              'Selasa: Seragam Putih Abu-abu',
                              'Rabu: Seragam Putih Batik',
                              'Kamis: Seragam Batik',
                              'Jumat: Seragam Pramuka',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPeraturanItem(
                    title: 'Tata Tertib Perpustakaan',
                    subtitle: 'Peraturan penggunaan perpustakaan',
                    icon: Icons.menu_book_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PeraturanDetailScreen(
                            title: 'Tata Tertib Perpustakaan',
                            rules: [
                              'Siswa wajib menjaga ketenangan di perpustakaan.',
                              'Siswa wajib mengembalikan buku yang dipinjam tepat waktu.',
                              'Siswa wajib menjaga kebersihan dan kerapian perpustakaan.',
                              'Siswa wajib mengisi buku tamu saat masuk perpustakaan.',
                              'Siswa wajib mematuhi jadwal buka tutup perpustakaan.',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeraturanItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    double height = 72,
    double radius = 20,
    double titleSize = 15,
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
                Icon(icon, size: 24, color: Colors.black),
                const SizedBox(width: 16),
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
                          color: Colors.black54,
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
}
