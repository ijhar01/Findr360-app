import 'package:flutter/material.dart';
import 'contact-page.dart';
import 'profile-page.dart';
import 'main.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
  });

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;

    switch (index) {
      case 0:
        page = const MainPage();
        break;

      case 1:
        page = const ContactPage();
        break;

      case 2:
        page = const AboutPage();
        break;

      default:
        page = const MainPage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              context,
              icon: Icons.home_rounded,
              label: "Home",
              index: 0,
            ),

            _navItem(
              context,
              icon: Icons.phone_rounded,
              label: "Contact",
              index: 1,
            ),

            _navItem(
              context,
              icon: Icons.person_rounded,
              label: "About",
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required int index,
      }) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () => _navigate(context, index),

      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: selected
                  ? const Color(0xFF1565C0)
                  : Colors.grey,
            ),

            const SizedBox(height: 3),

            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
                color: selected
                    ? const Color(0xFF1565C0)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}