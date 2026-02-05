import 'package:flutter/material.dart';

class StudentPage1 extends StatelessWidget {
  const StudentPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลนักเรียน'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- ส่วนแสดงรูปภาพ (จาก URL) ---
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // ทำมุมโค้งให้รูป
              child: Image.network(
                'https://scontent.fcnx1-1.fna.fbcdn.net/v/t39.30808-1/586252444_1210848734298337_1751353239766017535_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=100&ccb=1-7&_nc_sid=e99d92&_nc_eui2=AeHkmbyBCffiq5ePv8xoT3ptDouQ9UEAo9oOi5D1QQCj2llGh3nZWIpq7Tq9H0FvVB4M_B9vCKJsWTzXdaO5qobr&_nc_ohc=vU8ihSTKojIQ7kNvwGLTSIv&_nc_oc=AdlmcN86eNKUBRIqBIZu9Bmwra5avhxgdj3Wy1s5MEQA3vYI7FzmgaIP4SGoTUA0eXI&_nc_zt=24&_nc_ht=scontent.fcnx1-1.fna&_nc_gid=vVILlm9Cv8g5i2L0NEv80A&oh=00_AftN5CKWuNxwv_pOYU1BCyQVi4-RNumleSRKtB_AyROCVw&oe=69863568', // ลิงก์รูปภาพตัวอย่าง (เปลี่ยนได้ครับ)
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20), // เว้นระยะห่าง
            // --- ส่วนแสดงชื่อนักเรียน ---
            const Text(
              'ชื่อ: เลวลิด',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const Text(
              'ชั้น: ปริญาเอก 6/1',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}