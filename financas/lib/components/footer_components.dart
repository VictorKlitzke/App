import 'package:flutter/material.dart';

class FooterComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Footer content (no Scaffold wrapper)
        BottomNavigationBar(
          backgroundColor: const Color(0xFF0066CC),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/dashboard');
                break;
              case 1:
                Navigator.pushNamed(context, '/profile');

                break;
              case 2:
                Navigator.pushNamed(context, '/settings');
                break;
            }
          },
        ),
      ],
    );
  }
}
