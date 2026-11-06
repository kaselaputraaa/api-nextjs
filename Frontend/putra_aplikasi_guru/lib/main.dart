import 'package:flutter/material.dart';
import 'package:putra_aplikasi_guru/pages/page_dashboard.dart';
import 'package:putra_aplikasi_guru/pages/page_login.dart';
import 'package:putra_aplikasi_guru/pages/page_input.dart';
import 'package:putra_aplikasi_guru/pages/page_update.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const PageLogin(),
    );
  }
}
