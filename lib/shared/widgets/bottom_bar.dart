import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:my_amazon_app/features/cart/screens/cart_screen.dart';
import 'package:my_amazon_app/features/profile/screens/profile_screen.dart';
import 'package:my_amazon_app/features/home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            activeIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
          BottomNavigationBarItem(
            icon: const badges.Badge(
              badgeContent: Text('2', style: TextStyle(color: Colors.white)),
              child: Icon(Icons.shopping_cart_outlined),
            ),
            activeIcon: const badges.Badge(
              badgeContent: Text('2', style: TextStyle(color: Colors.white)),
              child: Icon(Icons.shopping_cart),
            ),
            label: l10n.cart,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalVar.selectedNavBarColor,
        unselectedItemColor: GlobalVar.unselectedNavBarColor,
        backgroundColor: GlobalVar.backgroundColor,
        iconSize: 28,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        elevation: 5,
      ),
    );
  }
}
