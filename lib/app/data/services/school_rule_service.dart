import '../models/school_rule_model.dart';
import 'storage_service.dart';

class SchoolRuleService {
  final StorageService _storageService = StorageService();
  final String _rulesFile = 'school_rules.json';

  Future<List<SchoolRule>> getAllRules() async {
    final rulesData = await _storageService.readJsonList(_rulesFile);
    return rulesData
        .map((data) => SchoolRule.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  Future<SchoolRule?> getRule(String id) async {
    final allRules = await getAllRules();
    try {
      return allRules.firstWhere((rule) => rule.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addRule(SchoolRule rule) async {
    await _storageService.appendToJsonList(_rulesFile, rule.toJson());
  }

  Future<void> updateRule(SchoolRule rule) async {
    final rules = await getAllRules();
    final index = rules.indexWhere((r) => r.id == rule.id);
    if (index != -1) {
      rules[index] = rule;
      final jsonList = rules.map((r) => r.toJson()).toList();
      await _storageService.writeJsonList(_rulesFile, jsonList);
    }
  }

  Future<void> deleteRule(String id) async {
    final rules = await getAllRules();
    rules.removeWhere((rule) => rule.id == id);
    final jsonList = rules.map((r) => r.toJson()).toList();
    await _storageService.writeJsonList(_rulesFile, jsonList);
  }

  // For demo purposes, create default school rules if none exist
  Future<void> createDefaultRules() async {
    if (!await _storageService.fileExists(_rulesFile)) {
      final defaultRules = [
        SchoolRule(
          id: 'R001',
          title: 'Terlambat ke sekolah',
          description: 'Siswa tidak diperbolehkan terlambat ke sekolah tanpa alasan yang jelas.',
          demeritPoints: 5,
        ).toJson(),
        SchoolRule(
          id: 'R002',
          title: 'Tidak mengenakan seragam lengkap',
          description: 'Siswa wajib mengenakan seragam sekolah lengkap sesuai peraturan.',
          demeritPoints: 5,
        ).toJson(),
        SchoolRule(
          id: 'R003',
          title: 'Tidak mengerjakan tugas',
          description: 'Siswa wajib mengerjakan dan mengumpulkan tugas tepat waktu.',
          demeritPoints: 5,
        ).toJson(),
        SchoolRule(
          id: 'R004',
          title: 'Membolos jam pelajaran',
          description: 'Siswa dilarang membolos jam pelajaran tanpa izin.',
          demeritPoints: 10,
        ).toJson(),
        SchoolRule(
          id: 'R005',
          title: 'Merusak fasilitas sekolah',
          description: 'Siswa dilarang merusak fasilitas sekolah dan harus bertanggung jawab jika ada kerusakan.',
          demeritPoints: 20,
        ).toJson(),
        SchoolRule(
          id: 'R006',
          title: 'Berkelahi',
          description: 'Siswa dilarang berkelahi di lingkungan sekolah.',
          demeritPoints: 30,
        ).toJson(),
      ];
      await _storageService.writeJsonList(_rulesFile, defaultRules);
    }
  }
} 