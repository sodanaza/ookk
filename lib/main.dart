import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/food_list_page.dart';
import 'pages/cart_page.dart';
import 'pages/order_history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// ✅ แยก HomePage ออกมา
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4CAF50),
              Color(0xFF2E7D32),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.restaurant_menu,
              size: 90,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            const Text(
              'Flutter Project รวมกลุ่ม',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            _menuCard(
              context,
              icon: Icons.fastfood,
              title: 'รายการอาหาร',
              subtitle: 'ดูเมนูอาหารทั้งหมด',
              page: const FoodListPage(),
            ),

            const SizedBox(height: 20),

            _menuCard(
              context,
              icon: Icons.shopping_cart,
              title: 'Cart',
              subtitle: 'ตะกร้าสินค้า',
              page: const CartPage(),
            ),

            const SizedBox(height: 20),

            _menuCard(
              context,
              icon: Icons.receipt_long,
              title: 'ประวัติการสั่งซื้อ',
              subtitle: 'รายการสั่งซื้อที่ผ่านมา',
              page: const OrderHistoryPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.green.shade600,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },
        ),
      ),
    );
  }
}
