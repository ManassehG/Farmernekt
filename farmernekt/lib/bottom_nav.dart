import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'navigation-components/farmeducation.dart';
import 'navigation-components/marketplacy.dart';
import 'navigation-components/community-networking.dart';
import 'navigation-components/farm-management.dart';
import 'navigation-components/user-details.dart';
import 'screens/Chatting/chatHomeScreen.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    UserDetailsPage(),
    FarmManagementPage(),
    EducationalContentPage(),
    MarketplacePage(),
    ChatHomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green,
        color: Colors.white,
        items: <Widget>[
          Icon(Icons.person, size: 30),
          Icon(Icons.agriculture, size: 30),
          Icon(Icons.book, size: 30),
          Icon(Icons.store, size: 30),
          Icon(Icons.people, size: 30),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Placeholder pages
class UserAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Authentication'),
      ),
      body: Center(
        child: Text(
          'User Registration, Login, Profile Setup',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
