import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:putra_aplikasi_guru/pages/page_dashboard.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController TxUsername = TextEditingController();
  final TextEditingController TxPassword = TextEditingController();

  bool isLoading = false;

  Future<void> prosesLogin() async {
    if (TxUsername.text.trim().isEmpty ||
        TxPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan password wajib diisi!'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': TxUsername.text.trim(),
          'password': TxPassword.text,
        }),
      );

      debugPrint('Status Login: ${response.statusCode}');
      debugPrint('Respons Login: ${response.body}');

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Ambil token dari respons API.
        // Sesuaikan jika token berada di dalam properti "data".
        final token = data is Map<String, dynamic>
            ? data['token']
            : null;

        if (token == null || token.toString().isEmpty) {
          throw Exception(
            'Token tidak ditemukan dalam respons API.',
          );
        }

        // Simpan token login.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());

        if (!mounted) return;

        // Masuk ke Dashboard.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Dashboard(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login gagal (${response.statusCode}): '
                  '${response.body}',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    TxUsername.dispose();
    TxPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.supervised_user_circle,
                  size: 60,
                ),

                const SizedBox(height: 12),

                const Text(
                  'Login',
                  style: TextStyle(fontSize: 30),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: TxUsername,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Input Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: TxPassword,
                  obscureText: true,
                  onSubmitted: (_) => prosesLogin(),
                  decoration: const InputDecoration(
                    labelText: 'Input Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : prosesLogin,
                    child: isLoading
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}