import 'package:flutter/material.dart';
import 'package:keepbook/setting.dart'; 
import 'Bookshop.dart';
import 'package:keepbook/Bookshelf.dart';
class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 125, 161, 197),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCircleButton(
            icon: Icons.shopping_cart,
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookshopPage()),
              );
            },
          ),
          _buildCircleButton(
            icon: Icons.collections_bookmark,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookshelfPage()),
              );
            },
          ),
          _buildCircleButton(
            icon: Icons.person,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onPressed}) {
    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
