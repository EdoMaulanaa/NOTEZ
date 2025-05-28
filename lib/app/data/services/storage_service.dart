import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<String> get _localPath async {
    if (kIsWeb) {
      return '';
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  Future<File> _getLocalFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<Map<String, dynamic>> readJsonFile(String filename) async {
    try {
      if (kIsWeb) {
        
        final prefs = await SharedPreferences.getInstance();
        final jsonStr = prefs.getString(filename);
        if (jsonStr != null) {
          return json.decode(jsonStr) as Map<String, dynamic>;
        }
        return {};
      } else {
        
        final file = await _getLocalFile(filename);
        if (await file.exists()) {
          final contents = await file.readAsString();
          return json.decode(contents) as Map<String, dynamic>;
        } else {
          return {};
        }
      }
    } catch (e) {
      return {};
    }
  }

  Future<List<dynamic>> readJsonList(String filename) async {
    try {
      if (kIsWeb) {
        
        final prefs = await SharedPreferences.getInstance();
        final jsonStr = prefs.getString(filename);
        if (jsonStr != null) {
          return json.decode(jsonStr) as List<dynamic>;
        }
        return [];
      } else {
        
        final file = await _getLocalFile(filename);
        if (await file.exists()) {
          final contents = await file.readAsString();
          return json.decode(contents) as List<dynamic>;
        } else {
          return [];
        }
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> writeJsonFile(String filename, Map<String, dynamic> data) async {
    if (kIsWeb) {
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(filename, json.encode(data));
    } else {
      
      final file = await _getLocalFile(filename);
      await file.writeAsString(json.encode(data));
    }
  }

  Future<void> writeJsonList(String filename, List<dynamic> data) async {
    if (kIsWeb) {
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(filename, json.encode(data));
    } else {
      
      final file = await _getLocalFile(filename);
      await file.writeAsString(json.encode(data));
    }
  }

  Future<void> appendToJsonList(String filename, Map<String, dynamic> item) async {
    List<dynamic> list = await readJsonList(filename);
    list.add(item);
    await writeJsonList(filename, list);
  }

  Future<bool> fileExists(String filename) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(filename);
    } else {
      final file = await _getLocalFile(filename);
      return file.exists();
    }
  }

  Future<void> deleteFile(String filename) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(filename);
    } else {
      final file = await _getLocalFile(filename);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  
  Future<void> exportData(String destinationPath) async {
    if (kIsWeb) {
      
      return;
    }
    
    final sourceDir = await _localPath;
    final sourceDirectory = Directory(sourceDir);
    final destinationDirectory = Directory(destinationPath);
    
    if (!await destinationDirectory.exists()) {
      await destinationDirectory.create(recursive: true);
    }
    
    await for (final entity in sourceDirectory.list()) {
      if (entity is File && entity.path.endsWith('.json')) {
        final fileName = entity.path.split('/').last;
        final newFile = File('$destinationPath/$fileName');
        await entity.copy(newFile.path);
      }
    }
  }

  Future<void> importData(String sourcePath) async {
    if (kIsWeb) {
      
      return;
    }
    
    final targetDir = await _localPath;
    final sourceDirectory = Directory(sourcePath);
    
    await for (final entity in sourceDirectory.list()) {
      if (entity is File && entity.path.endsWith('.json')) {
        final fileName = entity.path.split('/').last;
        final newFile = File('$targetDir/$fileName');
        await entity.copy(newFile.path);
      }
    }
  }
} 