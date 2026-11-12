import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ListTile(
            title: Text('Nama'),
            subtitle: Text('I Putu Mahadira Putra'),
          ),
          const ListTile(title: Text('NIM'), subtitle: Text('240040035')),
          const ListTile(
            title: Text('Akun'),
            subtitle: Text('admin@inventaris.com'),
          ),
          const Spacer(),
          OutlinedButton(onPressed: onLogout, child: const Text('Keluar')),
        ],
      ),
    );
  }
}
