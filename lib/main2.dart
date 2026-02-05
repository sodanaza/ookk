import 'package:flutter/material.dart';

class StudentPage2 extends StatelessWidget {
  const StudentPage2({super.key});

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
                'https://scontent.fcnx1-1.fna.fbcdn.net/v/t39.30808-1/572967992_1387728022876006_7456669436936147724_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=108&ccb=1-7&_nc_sid=e99d92&_nc_eui2=AeH1CaiLZGA1TXSJGLCFXSKewvg7JqQaF9PC-DsmpBoX0_nJ86k2Wa6CCPofeM_VUCOPUi8MV3rYVK8uHk-EGJXc&_nc_ohc=hVeQw0eRdEoQ7kNvwH1gKRE&_nc_oc=Adkp6uCAfT-gg6YMiIt9gcGokeCbpUcMkV6uggQBgzM8nse78pvIvCbw6zyEKqBcCko&_nc_zt=24&_nc_ht=scontent.fcnx1-1.fna&_nc_gid=0ytq9WAonZ9gKkc4mRfm8Q&oh=00_AfufmcdQzNsnM8rY21C33NSBtbjhNjf4JRszyX418MP9VA&oe=698621D5', // ลิงก์รูปภาพตัวอย่าง (เปลี่ยนได้ครับ)
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20), // เว้นระยะห่าง
            // --- ส่วนแสดงชื่อนักเรียน ---
            const Text(
              'ชื่อ: สุระชัย',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const Text(
              'ชั้น: ป.6',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
