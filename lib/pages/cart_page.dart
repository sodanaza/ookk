import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/cart_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<void> _checkout(BuildContext context) async {
    await FirebaseFirestore.instance.collection('orders').add({
      'total': CartService.totalPrice,
      'items': CartService.items.map((e) => {
        'name': e.name,
        'price': e.price,
        'qty': e.qty,
        'image': e.image,
      }).toList(),
      'createdAt': Timestamp.now(),
    });

    CartService.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('สั่งซื้อเรียบร้อยแล้ว 🎉')),
    );

    Navigator.pop(context);
  }

  Widget qtyButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ตะกร้าสินค้า'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: items.isEmpty
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 60, color: Color(0xFF2E7D32)),
                    SizedBox(height: 12),
                    Text(
                      'ยังไม่มีสินค้าในตะกร้า',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  /// 🧾 รายการสินค้า
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final item = items[i];

                        return Card(
                          elevation: 6,
                          margin: const EdgeInsets.only(bottom: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                /// รูปอาหาร
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    item.image,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),

                                /// รายละเอียด
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1B5E20),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${item.price} บาท / ชิ้น',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'รวม ${item.total} บาท',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF388E3C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// ปุ่ม + -
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        qtyButton(
                                          icon: Icons.remove,
                                          color: Colors.red,
                                          onTap: () {
                                            setState(() {
                                              if (item.qty > 1) {
                                                item.qty--;
                                              } else {
                                                CartService.items
                                                    .remove(item);
                                              }
                                            });
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            '${item.qty}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        qtyButton(
                                          icon: Icons.add,
                                          color: Colors.green,
                                          onTap: () {
                                            setState(() {
                                              item.qty++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// 💳 สรุปราคา
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(26),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'รวมทั้งหมด',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${CartService.totalPrice} บาท',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF2E7D32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            icon: const Icon(Icons.payment),
                            label: const Text(
                              'ยืนยันสั่งซื้อ',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: () => _checkout(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
