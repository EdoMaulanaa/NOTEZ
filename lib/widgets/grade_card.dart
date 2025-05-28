import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/grade_data.dart';

class GradeCard extends StatelessWidget {
  final String title;
  final List<double> grades;
  final double? examGrade;
  final List<double>? pjblGrades;
  final bool isPjbl;

  const GradeCard({
    super.key,
    required this.title,
    required this.grades,
    this.examGrade,
    this.pjblGrades,
    this.isPjbl = false,
  });

  @override
  Widget build(BuildContext context) {
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
                if (!isPjbl) ...[
                  _buildGradeSection('Nilai Harian', grades),
                  if (examGrade != null) ...[
                    const SizedBox(height: 16),
                    _buildGradeSection('Nilai Ujian', [examGrade!]),
                  ],
                ] else if (pjblGrades != null) ...[
                  _buildGradeSection('Nilai PJBL', pjblGrades!),
                ],
                const SizedBox(height: 16),
                _buildAverageSection(),
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
                'Harian ${index + 1}: ${grade.toStringAsFixed(1)}',
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

  Widget _buildAverageSection() {
    double average = 0;
    if (isPjbl && pjblGrades != null) {
      average = pjblGrades!.reduce((a, b) => a + b) / pjblGrades!.length;
    } else {
      int count = grades.length;
      double sum = grades.reduce((a, b) => a + b);
      if (examGrade != null) {
        sum += examGrade!;
        count++;
      }
      average = sum / count;
    }

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
