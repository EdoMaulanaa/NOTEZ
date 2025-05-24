Product Requirements Document (PRD) – Notez (Offline tanpa Database)
1. Nama Aplikasi
Notez – Aplikasi Mobile Pemantauan Akademik Siswa
2. Latar Belakang
Notez adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu siswa dan wali murid memantau informasi akademik, termasuk identitas, absensi, nilai, dan poin perilaku secara offline. Aplikasi ini beroperasi tanpa database tradisional, dengan memanfaatkan penyimpanan lokal sederhana (misalnya file JSON atau SharedPreferences).
3. Tujuan
• Menyediakan akses instan dan offline ke data siswa.
• Menghilangkan kebutuhan akan konektivitas internet atau sistem backend.
• Mempermudah monitoring performa akademik dan kedisiplinan siswa.
4. Target Pengguna
• Siswa SMP/SMA
• Wali murid
• Guru/Operator (untuk input data manual)
5. Navigasi Aplikasi (Sesuai Desain Figma) https://www.figma.com/design/c9KgIv8EMYrGUZt7qmbj8D/NOTEZ?node-id=0-1&t=Jx6iIjFgp0pQogox-1
1. Splash Screen – Menampilkan logo dan nama aplikasi.
2. Login Screen – Form login dengan input email dan password.
3. Home Screen – Menampilkan:
   • Nama siswa dan detail kelas
   • Total poin pelanggaran dan penghargaan
   • Shortcut ke halaman nilai, absensi, dan peraturan
4. Nilai Screen – Tabel nilai per mata pelajaran dan per semester.
5. Poin Screen – Riwayat pelanggaran dan penghargaan.
6. Absensi Screen – Riwayat absensi lengkap.
7. Peraturan Screen – Daftar peraturan sekolah.
8. Profil Screen – Informasi akun dan tombol logout.
Navigasi menggunakan bottom navigation dengan tab: Beranda, Nilai, Poin, dan Profil.
6. Fitur Utama
• Splash dan login lokal
• Ringkasan dashboard
• Data identitas siswa
• Absensi harian
• Nilai per mata pelajaran
• Pelanggaran dan penghargaan
• Daftar peraturan
• Logout & pengaturan akun
7. Penyimpanan Data
• Data disimpan secara lokal dalam format file (JSON atau text) menggunakan `path_provider`.
• Tidak menggunakan SQLite atau database eksternal.
• Data bisa di-input manual atau melalui fitur import.
8. Kebutuhan Teknis
• Flutter
• Penyimpanan lokal (File I/O, SharedPreferences)
• State Management (Provider/Riverpod)
• File Picker (untuk import/export)
9. Kriteria Penerimaan
• Aplikasi menampilkan semua informasi dengan benar dari file lokal.
• Navigasi berjalan lancar dari splash hingga logout.
• Data tidak hilang setelah aplikasi ditutup.
10. Indikator Keberhasilan
• Aplikasi dapat digunakan sepenuhnya tanpa koneksi internet.
• Semua fitur utama dapat diakses dan ditampilkan dengan benar.
• Pengguna dapat login, melihat data, dan logout tanpa error.
11. Risiko & Mitigasi
• Risiko kehilangan data jika file rusak – Mitigasi dengan fitur backup/export.
• Identitas ganda tanpa database – Gunakan ID unik sederhana berbasis nama + angka.
• Kesalahan input – Validasi ketat pada form input.
