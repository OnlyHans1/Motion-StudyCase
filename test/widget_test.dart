import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktracker_motion/main.dart';

void main() {
  testWidgets('Menambah, mencentang, dan menghapus tugas',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(
      find.text('Belum ada tugas.\nTulis tugas baru di atas lalu tekan Simpan.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'Belajar Flutter');
    await tester.tap(find.text('Simpan'));
    await tester.pump();

    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Belum selesai'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(find.text('Selesai'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();

    expect(find.text('Belajar Flutter'), findsNothing);
  });
}
