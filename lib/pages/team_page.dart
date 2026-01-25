import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Our Team'),
        centerTitle: true,
        elevation: 0,
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.group,
                    size: 60,
                    color: Color(0xFF2E7D32),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ทีมผู้พัฒนาแอป',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            TeamCard(
              image: 'assets/team/member1.jpg',
              name: 'นายฉลองสิริ แลวริด',
              role: 'Frontend / UI Design',
              id: 'รหัสนักศึกษา 68319010001',
            ),

            TeamCard(
              image: 'assets/team/member2.jpg',
              name: 'นายปิยะวัชร์ สุระชัย',
              role: 'Backend / Logic',
              id: 'รหัสนักศึกษา 683190100012',
            ),

            TeamCard(
              image: 'assets/team/member3.jpg',
              name: 'นายพีรดนย์ บุตรขนทอง',
              role: 'CI/CD & Deploy',
              id: 'รหัสนักศึกษา 683190100013',
            ),
          ],
        ),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  final String id;

  const TeamCard({
    super.key,
    required this.image,
    required this.name,
    required this.role,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF4CAF50),
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 38,
                backgroundImage: AssetImage(image),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: const [
                      Icon(Icons.work, size: 18, color: Color(0xFF388E3C)),
                      SizedBox(width: 6),
                    ],
                  ),
                  Text(role),

                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.badge, size: 18, color: Color(0xFF388E3C)),
                      SizedBox(width: 6),
                    ],
                  ),
                  Text(id),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
