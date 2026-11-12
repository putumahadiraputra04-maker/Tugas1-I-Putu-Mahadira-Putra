import 'package:flutter/material.dart';

import '../models/barang.dart';
import '../viewmodels/barang_viewmodel.dart';
import 'form_page.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key, required this.vm});

  final BarangViewModel vm;

  Future<void> _confirmDelete(BuildContext context, Barang b) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus data?'),
        content: Text('${b.nama} akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) await vm.delete(b.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        if (vm.items.isEmpty) {
          return const Center(
            child: Text('Belum ada data. Tekan + untuk menambah.'),
          );
        }
        return ListView.separated(
          itemCount: vm.items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final b = vm.items[i];
            return ListTile(
              title: Text(b.nama),
              subtitle: Text('${b.kategori} • ${b.jumlah} pcs • ${b.tanggal}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Ubah',
                    icon: const Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormPage(vm: vm, barang: b),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Hapus',
                    icon: const Icon(Icons.delete),
                    onPressed: () => _confirmDelete(context, b),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
