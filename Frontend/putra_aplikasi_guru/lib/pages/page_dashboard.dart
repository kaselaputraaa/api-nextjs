import 'package:flutter/material.dart';
import 'page_view_user.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4FF),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          // Judul Dashboard
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Icon(
                  Icons.dashboard,
                  color: Color(0xFF34546A),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34546A),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  color: const Color(0xFF34546A),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Expanded( //menu dashboard
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,

              children: [
                menuCard(
                  icon: Icons.visibility_outlined,
                  title: 'Lihat Data',
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageViewUser(),
                      ),
                    );
                  },
                ),

                menuCard(
                  icon: Icons.add_box_outlined,
                  title: 'Input Data',
                  color: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, '/input');
                  },
                ),

                menuCard(
                  icon: Icons.edit_note,
                  title: 'Update Data',
                  color: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, '/update');
                  },
                ),

                menuCard(
                  icon: Icons.delete_outline,
                  title: 'Delete Data',
                  color: Colors.white,
                  onTap: () {},
                ),

                menuCard(
                  icon: Icons.person_outline,
                  title: 'Profiles',
                  color: Colors.white,
                  onTap: () {},
                ),

                menuCard(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  color: Colors.white,
                  onTap: () {},
                ),

                menuCard(
                  icon: Icons.arrow_back,
                  title: 'Back',
                  color: Colors.white,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 28,
                color: const Color(0xFF34546A),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}