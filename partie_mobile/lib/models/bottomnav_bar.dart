import 'package:flutter/material.dart';

class CustomBottomNavigationBar {
  static BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Color(0xFF1A73E8),
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
          label: 'Programme',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.call,
            color: Colors.black,
          ),
          label: 'Contact',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}
