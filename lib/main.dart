import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController judulController = TextEditingController();
  final List<String> daftarTugas = [];
  final List<bool> daftarSelesai = [];

  @override
  void dispose() {
    judulController.dispose();
    super.dispose();
  }

  void tambahTugas() {
    final judul = judulController.text.trim();
    if (judul.isEmpty) {
      return;
    }

    setState(() {
      daftarTugas.add(judul);
      daftarSelesai.add(false);
    });

    judulController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget isiDaftar;
    if (daftarTugas.isEmpty) {
      isiDaftar = const Center(
        child: Text(
          'Belum ada tugas.\nTulis tugas baru di atas lalu tekan Simpan.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      isiDaftar = ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: daftarTugas.length,
        itemBuilder: (context, index) {
          double tinggiTumpukan = 0.65;
          if (index == daftarTugas.length - 1) {
            tinggiTumpukan = 1.0;
          }

          return Align(
            heightFactor: tinggiTumpukan,
            alignment: Alignment.topCenter,
            child: CardTask(
              judul: daftarTugas[index],
              sudahSelesai: daftarSelesai[index],
              urutan: index,
              onCentang: () {
                setState(() {
                  daftarSelesai[index] = !daftarSelesai[index];
                });
              },
              onHapus: () {
                setState(() {
                  daftarTugas.removeAt(index);
                  daftarSelesai.removeAt(index);
                });
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.task_alt, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Catatan Saya',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Daftar Pribadi',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Catatan\nhari ini',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: judulController,
                      decoration: InputDecoration(
                        hintText: 'Tulis judul tugas...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: tambahTugas,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Daftar Tugas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: isiDaftar),
            ],
          ),
        ),
      ),
    );
  }
}
