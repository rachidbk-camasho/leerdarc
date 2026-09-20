import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/models.dart';

class DarijaContent {
  static Future<List<DarijaLevel>>? _cache;

  static Future<List<DarijaLevel>> load() => _cache ??= _load();

  static Future<List<DarijaLevel>> _load() async {
    final raw = await rootBundle.loadString('assets/data/content.json');
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return (decoded['levels'] as List)
        .map((e) => DarijaLevel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
