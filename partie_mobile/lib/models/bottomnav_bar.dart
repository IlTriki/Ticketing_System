import 'package:flutter/material.dart';
import 'package:partie_mobile/models/navigator_function.dart';
import 'package:partie_mobile/pages/contact.dart';
import 'package:partie_mobile/pages/home.dart';
import 'package:partie_mobile/pages/profil.dart';
import 'package:partie_mobile/pages/programme.dart';

class CustomBottomNavigationBar {
  static BottomNavigationBar buildBottomNavigationBar(
      int currentIndex, context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              navigateToPage(context, const HomePage());
              break;
            case 1:
              navigateToPage(context, const ProgrammePage());
              break;
            case 2:
              navigateToPage(context, const ContactPage());
              break;
            case 3:
              navigateToPage(context, const ProfilPage());
              break;
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: currentIndex == 0 ? const Color(0xFF1A73E8) : Colors.black,
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            color: currentIndex == 1 ? const Color(0xFF1A73E8) : Colors.black,
          ),
          label: 'Programme',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.call,
            color: currentIndex == 2 ? const Color(0xFF1A73E8) : Colors.black,
          ),
          label: 'Contact',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: currentIndex == 3 ? const Color(0xFF1A73E8) : Colors.black,
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}
