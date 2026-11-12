import 'package:flutter/material.dart';

import 'views/login_page.dart';

void main() => runApp(const InventarisApp());

class InventarisApp extends StatelessWidget {
  const InventarisApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Satu warna utama (indigo), latar putih.
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      surface: Colors.white,
    );
    return MaterialApp(
      title: 'InventarisKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
