import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/barang.dart';

/// Satu-satunya kelas yang mengakses penyimpanan lokal (SharedPreferences).
class BarangRepository {
  static const _key = 'barang_list';

  Future<List<Barang>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => Barang.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveAll(List<Barang> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  Future<void> add(Barang barang) async {
    final items = await getAll();
    items.add(barang);
    await _saveAll(items);
  }

  Future<void> update(Barang barang) async {
    final items = await getAll();
    final i = items.indexWhere((e) => e.id == barang.id);
    if (i != -1) items[i] = barang;
    await _saveAll(items);
  }

  Future<void> delete(String id) async {
    final items = await getAll();
    items.removeWhere((e) => e.id == id);
    await _saveAll(items);
  }
}
