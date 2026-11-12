import 'package:flutter/material.dart';

import '../models/barang.dart';
import '../viewmodels/barang_viewmodel.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.vm, this.barang});

  final BarangViewModel vm;
  final Barang? barang; // null = tambah, ada isi = ubah

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late final _namaC = TextEditingController(text: widget.barang?.nama);
  late final _kategoriC = TextEditingController(text: widget.barang?.kategori);
  late final _jumlahC =
      TextEditingController(text: widget.barang?.jumlah.toString());
  late final _tanggalC = TextEditingController(text: widget.barang?.tanggal);

  @override
  void dispose() {
    _namaC.dispose();
    _kategoriC.dispose();
    _jumlahC.dispose();
    _tanggalC.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _tanggalC.text = picked.toIso8601String().substring(0, 10);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final b = Barang(
      id: widget.barang?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      nama: _namaC.text.trim(),
      kategori: _kategoriC.text.trim(),
      jumlah: int.parse(_jumlahC.text.trim()),
      tanggal: _tanggalC.text,
    );
    if (widget.barang == null) {
      await widget.vm.add(b);
    } else {
      await widget.vm.update(b);
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  String? _required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null;

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.barang != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Ubah Barang' : 'Tambah Barang')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaC,
                decoration: const InputDecoration(labelText: 'Nama barang'),
                validator: (v) => _required(v, 'Nama'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kategoriC,
                decoration: const InputDecoration(labelText: 'Kategori'),
                validator: (v) => _required(v, 'Kategori'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jumlahC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah'),
                validator: (v) {
                  final s = v?.trim() ?? '';
                  if (s.isEmpty) return 'Jumlah wajib diisi';
                  final n = int.tryParse(s);
                  if (n == null || n < 0) return 'Jumlah harus angka >= 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tanggalC,
                readOnly: true,
                onTap: _pickDate,
                decoration: const InputDecoration(
                  labelText: 'Tanggal masuk',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (v) => _required(v, 'Tanggal'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
