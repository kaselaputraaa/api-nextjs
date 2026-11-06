
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageViewUser extends StatefulWidget {
  const PageViewUser({super.key});

  @override
  State<PageViewUser> createState() => _PageViewUserState();
}

class _PageViewUserState extends State<PageViewUser> {
  late Future<List<dynamic>> futureSiswa;

  @override
  void initState() {
    super.initState();
    futureSiswa = getDataUser();
  }

  // =====================================
  // GET DATA SISWA
  // =====================================

  Future<List<dynamic>> getDataUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan. Silakan login kembali.');
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/siswa'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Status API: ${response.statusCode}');
    debugPrint('Respons API: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded;
      }

      if (decoded is Map<String, dynamic>) {
        final data = decoded['data'];

        if (data is List) {
          return data;
        }
      }

      throw Exception('Format respons API tidak sesuai.');
    } else {
      throw Exception(
        'Gagal mengambil data siswa: ${response.body}',
      );
    }
  }

  // =====================================
  // EDIT DATA SISWA
  // =====================================

  Future<void> editSiswa(
      int id,
      Map<String, TextEditingController> c,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/siswa/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nipd': c['nipd']!.text,
        'nama_lengkap': c['nama_lengkap']!.text,
        'jenis_kelamin': c['jenis_kelamin']!.text,
        'alamat': c['alamat']!.text,
        'kelas': c['kelas']!.text,
        'jurusan': c['jurusan']!.text,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengedit data: ${response.body}');
    }
  }

  // =====================================
  // FORM EDIT SISWA
  // =====================================

  Future<void> showEditDialog(Map<String, dynamic> data) async {
    final fields = [
      'nipd',
      'nama_lengkap',
      'jenis_kelamin',
      'alamat',
      'kelas',
      'jurusan',
    ];

    final controllers = <String, TextEditingController>{};

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: '${data[field] ?? ''}',
      );
    }

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Data Siswa'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: fields.map((field) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: controllers[field],
                    decoration: InputDecoration(
                      labelText: field,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await editSiswa(
                    int.parse('${data['id']}'),
                    controllers,
                  );

                  if (!mounted) return;

                  Navigator.pop(dialogContext);

                  setState(() {
                    futureSiswa = getDataUser();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil diubah!'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e')),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    for (final controller in controllers.values) {
      controller.dispose();
    }
  }

  // =====================================
  // HAPUS DATA SISWA
  // =====================================

  Future<void> hapusSiswa(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('http://127.0.0.1:3000/api/siswa/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200 &&
        response.statusCode != 204) {
      throw Exception('Gagal menghapus data: ${response.body}');
    }

    if (!mounted) return;

    setState(() {
      futureSiswa = getDataUser();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil dihapus!'),
      ),
    );
  }

  // =====================================
  // KONFIRMASI HAPUS
  // =====================================

  Future<void> konfirmasiHapus(int id) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text(
            'Apakah kamu yakin ingin menghapus data siswa ini?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (yakin == true) {
      try {
        await hapusSiswa(id);
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  // =====================================
  // BUILD UI
  // =====================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Siswa'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureSiswa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Terjadi kesalahan:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Belum ada data siswa.'),
            );
          }

          final siswa = snapshot.data!;

          return ListView.builder(
            itemCount: siswa.length,
            itemBuilder: (context, index) {
              final user = siswa[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${user['id'] ?? '-'}'),
                  ),

                  title: Text(
                    '${user['nama_lengkap'] ?? '-'}',
                  ),

                  subtitle: Text(
                    'NIPD: ${user['nipd'] ?? '-'}\n'
                        'Jenis Kelamin: ${user['jenis_kelamin'] ?? '-'}\n'
                        'Alamat: ${user['alamat'] ?? '-'}\n'
                        'Kelas: ${user['kelas'] ?? '-'}\n'
                        'Jurusan: ${user['jurusan'] ?? '-'}',
                  ),

                  isThreeLine: true,

                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      // BUTTON EDIT
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          showEditDialog(user);
                        },
                      ),

                      // BUTTON HAPUS
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          konfirmasiHapus(
                            int.parse('${user['id']}'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
