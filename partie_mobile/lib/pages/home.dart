import 'package:flutter/material.dart';
import 'package:partie_mobile/pages/accueil.dart';
import 'package:partie_mobile/pages/contact.dart';
import 'package:partie_mobile/pages/profil.dart';
import 'package:partie_mobile/pages/programme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BottomNavigationBar Example',
      home: HomePage(objectId: ''),
    );
  }
}

class HomePage extends StatefulWidget {
  final String objectId;

  const HomePage({Key? key, required this.objectId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AccueilPage(objectId: widget.objectId),
      ProgrammePage(objectId: widget.objectId),
      const ContactPage(),
      ProfilPage(objectId: widget.objectId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: widget.currentIndex == 0
                ? const Color(0xFF1A73E8)
                : Colors.black,
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            color: widget.currentIndex == 1
                ? const Color(0xFF1A73E8)
                : Colors.black,
          ),
          label: 'Programme',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.call,
            color: widget.currentIndex == 2
                ? const Color(0xFF1A73E8)
                : Colors.black,
          ),
          label: 'Contact',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: widget.currentIndex == 3
                ? const Color(0xFF1A73E8)
                : Colors.black,
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}
