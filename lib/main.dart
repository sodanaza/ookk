import 'package:flutter/material.dart';
// import ไฟล์อื่นๆ ของคุณที่นี่
import 'main1.dart';
import 'main2.dart';
import 'main3.dart';

void main() {
  runApp(const MaterialApp(home: MainMenu()));
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เมนูเลือกหน้า')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menuButton(
            context,
            'ไปหน้า main1 (ข้อมูลนักเรียน)',
            const StudentPage1(),
          ),
          _menuButton(context, 'ไปหน้า main2', const StudentPage2()),
          _menuButton(context, 'ไปหน้า main3', const StudentPage3()),
        ],
      ),
    );
  }

  Widget _menuButton(BuildContext context, String title, Widget page) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
