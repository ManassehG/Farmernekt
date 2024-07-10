import 'package:flutter/material.dart';
import 'package:farmernekt/models/chatUsersModel.dart';
import 'package:farmernekt/widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "John Mwangi",
        messageText: "I actually saw the plants are healthy",
        imageURL: "assets/images/userImage1.jpg",
        time: "Now"),
    ChatUsers(
        name: "Glady's Njoki",
        messageText: "That's Great",
        imageURL: "assets/images/userImage2.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "Nick Waweru",
        messageText: "Hey how much is a kg of onions?",
        imageURL: "assets/images/userImage3.jpg",
        time: "31 June"),
    ChatUsers(
        name: "Joel Kanyi",
        messageText: "My chickens are now 8 months old",
        imageURL: "assets/images/userImage4.jpg",
        time: "28 June"),
    ChatUsers(
        name: "Mwangi Agriculture",
        messageText: "Thankyou, It's awesome",
        imageURL: "assets/images/userImage5.jpg",
        time: "23 June"),
    ChatUsers(
        name: "Nancy Okayo",
        messageText: "Will update you in evening",
        imageURL: "assets/images/userImage6.jpg",
        time: "17 June"),
    ChatUsers(
        name: "Mwangi wa Pigs",
        messageText: "Nitumie ile formula ya kufeed nguruwe",
        imageURL: "assets/images/userImage7.jpg",
        time: "24 May"),
    ChatUsers(
        name: "John Mwasondo",
        messageText: "How are you?",
        imageURL: "assets/images/userImage8.jpg",
        time: "18 May"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index]
                      .messageText, // Example assuming secondaryText is your messageText
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
