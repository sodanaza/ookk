import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/food_data.dart';
import '../models/food_item.dart';
import 'food_detail_page.dart';
import 'video_page.dart';
import 'cart_page.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  double? lat;
  double? lng;

  @override
  void initState() {
    super.initState();
    _getGPS();
  }

  Future<void> _getGPS() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
    });
  }

  Future<void> _navigateToShop(FoodItem f) async {
    if (lat == null || lng == null) return;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=$lat,$lng'
      '&destination=${f.lat},${f.lng}',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// 🔘 ปุ่มไอคอนแนวนอน
  Widget actionIcon({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// 🍽 รายการอาหาร
  Widget foodSection(String title, List<FoodItem> foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
        ListView.builder(
          itemCount: foods.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final f = foods[i];
            final distance = Geolocator.distanceBetween(
                  lat!,
                  lng!,
                  f.lat,
                  f.lng,
                ) /
                1000;

            return Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    /// 🔝 ข้อมูลหลัก
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            f.image,
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 60),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                f.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Chip(
                                avatar: const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                backgroundColor:
                                    const Color(0xFF2E7D32),
                                label: Text(
                                  '${distance.toStringAsFixed(2)} กม.',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    const Divider(),

                    /// 🔥 ไอคอนแนวนอน
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        actionIcon(
                          icon: Icons.info_outline,
                          color: Colors.blue,
                          label: 'รายละเอียด',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    FoodDetailPage(food: f),
                              ),
                            );
                          },
                        ),
                        actionIcon(
                          icon: Icons.play_circle_outline,
                          color: Colors.red,
                          label: 'วิดีโอ',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VideoPage(
                                  title: f.name,
                                  videoUrl: f.videoUrl,
                                ),
                              ),
                            );
                          },
                        ),
                        actionIcon(
                          icon: Icons.directions,
                          color: Colors.green,
                          label: 'นำทาง',
                          onTap: () => _navigateToShop(f),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (lat == null || lng == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        title: const Text('ร้านอาหารใกล้ฉัน'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getGPS,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🗺 แผนที่
           

            foodSection('🍛 อาหารคาว', savoryFoods),
            const SizedBox(height: 10),
            foodSection('🍰 อาหารหวาน', sweetFoods),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
