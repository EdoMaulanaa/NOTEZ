import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../models/attendance_data.dart';
import '../../widgets/report_button.dart';

class AbsensiDetailScreen extends StatefulWidget {
  final String type;
  final String title;

  const AbsensiDetailScreen({
    super.key,
    required this.type,
    required this.title,
  });

  @override
  State<AbsensiDetailScreen> createState() => _AbsensiDetailScreenState();
}

class _AbsensiDetailScreenState extends State<AbsensiDetailScreen> {
  AttendanceData? _attendance;

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  Future<void> _loadAttendance() async {
    final attendance = await readAttendance();
    setState(() {
      _attendance = attendance;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecords = _attendance?.records
            .where((record) => record.type == widget.type)
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title,
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ReportButton(screenName: widget.title),
          ),
        ],
      ),
      body: _attendance == null
          ? const Center(child: CircularProgressIndicator())
          : filteredRecords.isEmpty
              ? Center(
                  child: Text(
                    'Belum ada data ${widget.title.toLowerCase()}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: filteredRecords.length,
                  itemBuilder: (context, index) {
                    final record = filteredRecords[index];
                    final date = DateFormat('dd MMMM yyyy')
                        .format(DateTime.parse(record.date));
                    final color = record.type == 'alpha'
                        ? Colors.red
                        : record.type == 'izin'
                            ? Colors.orange
                            : Colors.blue;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
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
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        title: Text(
                          date,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: record.note != null
                            ? Text(
                                record.note!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              )
                            : null,
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
