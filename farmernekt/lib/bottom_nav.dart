import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'navigation-components/farmeducation.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    UserAuthPage(),
    FarmManagementPage(),
    EducationalContentPage(),
    MarketplacePage(),
    CommunityNetworkingPage(),
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

class FarmManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm Management'),
      ),
      body: Center(
        child: Text(
          'Crop and Livestock Tracking, Set Reminders',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MarketplacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
      ),
      body: Center(
        child: Text(
          'List Items for Sale, Browse and Search Items',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class CommunityNetworkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community and Networking'),
      ),
      body: Center(
        child: Text(
          'Farmer Profiles, Messaging System',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
