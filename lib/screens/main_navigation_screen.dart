import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'product_list_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

/// MAIN NAVIGATION SCREEN
/// ----------------------
/// Ye screen bottom navigation ko control karti hai
/// Yahi decide hota hai kaunsa tab visible hoga
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  /// Current selected tab index
  int _selectedIndex = 0;

  /// Screens list (order important)
  final List<Widget> _screens = const [
    ProductListScreen(), // index 0
    CartScreen(), // index 1
    ProfileScreen(), // index 2
  ];

  /// Tab change handler
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // UI rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Cart provider (badge ke liye)
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: _screens[_selectedIndex], // 👈 active screen

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        items: [
          /// HOME TAB
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          /// CART TAB (with badge)
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.items.length.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),

          /// PROFILE TAB
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
