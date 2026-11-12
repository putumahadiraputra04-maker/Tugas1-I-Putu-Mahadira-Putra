import 'package:flutter/foundation.dart';

import '../models/barang.dart';
import '../repositories/barang_repository.dart';

class BarangViewModel extends ChangeNotifier {
  BarangViewModel(this._repo);

  final BarangRepository _repo;
  List<Barang> items = [];

  Future<void> load() async {
    items = await _repo.getAll();
    notifyListeners();
  }

  Future<void> add(Barang barang) async {
    await _repo.add(barang);
    await load();
  }

  Future<void> update(Barang barang) async {
    await _repo.update(barang);
    await load();
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    await load();
  }
}
