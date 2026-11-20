import 'package:flutter/material.dart';

class CardTask extends StatelessWidget {
  const CardTask({
    super.key,
    required this.judul,
    required this.sudahSelesai,
    required this.urutan,
    required this.onCentang,
    required this.onHapus,
  });

  final String judul;
  final bool sudahSelesai;
  final int urutan;
  final void Function() onCentang;
  final void Function() onHapus;

  @override
  Widget build(BuildContext context) {
    Color warnaKartu = Colors.deepPurple;
    Color warnaTeks = Colors.white;

    if (urutan % 4 == 1) {
      warnaKartu = Colors.amber;
      warnaTeks = Colors.black;
    } else if (urutan % 4 == 2) {
      warnaKartu = Colors.lightGreen;
      warnaTeks = Colors.black;
    } else if (urutan % 4 == 3) {
      warnaKartu = Colors.black;
      warnaTeks = Colors.white;
    }

    TextDecoration garisCoret = TextDecoration.none;
    String statusTeks = 'Belum selesai';
    if (sudahSelesai) {
      garisCoret = TextDecoration.lineThrough;
      statusTeks = 'Selesai';
    }

    return SizedBox(
      height: 125,
      child: Card(
        color: warnaKartu,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: sudahSelesai,
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    side: BorderSide(color: warnaTeks, width: 1.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onChanged: (value) {
                      onCentang();
                    },
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          judul,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: warnaTeks,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            decoration: garisCoret,
                          ),
                        ),
                        Text(
                          statusTeks,
                          style: TextStyle(
                            color: warnaTeks,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onHapus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Icon(Icons.delete_outline, size: 20),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusTeks,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
