import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../models/point_data.dart';
import '../../widgets/report_button.dart';

class PoinDetailScreen extends StatefulWidget {
  final String type;
  final String title;

  const PoinDetailScreen({
    super.key,
    required this.type,
    required this.title,
  });

  @override
  State<PoinDetailScreen> createState() => _PoinDetailScreenState();
}

class _PoinDetailScreenState extends State<PoinDetailScreen> {
  PointData? _points;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    try {
      final points = await readPoints();
      
      
      if (mounted) {
        setState(() {
          _points = points;
        });
      }
    } catch (e) {
      print('Error loading points in detail screen: $e');
      
      if (mounted) {
        setState(() {
          
          _points = PointData(records: []);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecords = _points?.records
            .where((record) => record.type == widget.type)
            .toList() ??
        [];
        
    
    filteredRecords.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));

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
      body: _points == null
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
              : Column(
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
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
                              widget.type == 'pelanggaran' ? 'Total Poin Pelanggaran' : 'Total Poin Prestasi',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.type == 'pelanggaran' 
                                ? '${_points?.totalPelanggaranPoints ?? 0}' 
                                : '${_points?.totalPrestasiPoints ?? 0}',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: widget.type == 'pelanggaran' ? Colors.red : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Riwayat ${widget.title}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${filteredRecords.length} item',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: filteredRecords.length,
                        itemBuilder: (context, index) {
                          final record = filteredRecords[index];
                          final date = DateFormat('dd MMMM yyyy')
                              .format(DateTime.parse(record.date));
                          final color = record.type == 'pelanggaran'
                              ? Colors.red
                              : Colors.green;
                          final pointText = record.type == 'pelanggaran'
                              ? '-${record.points} poin'
                              : '+${record.points} poin';

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
                                record.description,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                date,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  pointText,
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
                    ),
                  ],
                ),
    );
  }
}
