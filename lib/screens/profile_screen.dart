import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile"), centerTitle: true),

      body: user == null
          ? const Center(child: Text("No user data"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [
                  /// PROFILE AVATAR
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// USER NAME
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// USER EMAIL
                  Text(user.email, style: const TextStyle(color: Colors.grey)),

                  const SizedBox(height: 24),

                  /// PROFILE OPTIONS
                  _profileOption(
                    icon: Icons.shopping_bag,
                    title: "My Orders",
                    onTap: () {
                      _showComingSoon(context);
                    },
                  ),

                  _profileOption(
                    icon: Icons.location_on,
                    title: "Saved Addresses",
                    onTap: () {
                      _showComingSoon(context);
                    },
                  ),

                  _profileOption(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {
                      _showComingSoon(context);
                    },
                  ),

                  const SizedBox(height: 30),

                  /// LOGOUT BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await auth.logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // -----------------------------
  // REUSABLE PROFILE OPTION TILE
  // -----------------------------
  Widget _profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),

        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  /// TEMP COMING SOON DIALOG
  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Coming Soon"),
        content: const Text("This feature will be added later."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
