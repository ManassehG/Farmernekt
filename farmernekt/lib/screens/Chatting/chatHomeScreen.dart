import 'package:flutter/material.dart';
import 'package:farmernekt/screens/Chatting/ChatPage.dart';

class ChatHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats", // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Channels", // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile", // Use label instead of title
          ),
        ],
      ),
    );
  }
}
