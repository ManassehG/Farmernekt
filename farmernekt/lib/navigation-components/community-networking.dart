import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CommunityNetworkingPage(),
    );
  }
}

class CommunityNetworkingPage extends StatefulWidget {
  @override
  _CommunityNetworkingPageState createState() =>
      _CommunityNetworkingPageState();
}

class _CommunityNetworkingPageState extends State<CommunityNetworkingPage> {
  final TextEditingController _postController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _createPost() async {
    if (_postController.text.isNotEmpty) {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        await _firestore.collection('posts').add({
          'authorId': user.uid,
          'authorName': userDoc['name'],
          'content': _postController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'likes': [],
        });
        _postController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Networking'),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InboxPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                labelText: 'Write a post',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _createPost,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('posts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                var posts = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return PostWidget(post);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final DocumentSnapshot post;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PostWidget(this.post);

  void _likePost() async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (post['likes'].contains(user.uid)) {
        _firestore.collection('posts').doc(post.id).update({
          'likes': FieldValue.arrayRemove([user.uid]),
        });
      } else {
        _firestore.collection('posts').doc(post.id).update({
          'likes': FieldValue.arrayUnion([user.uid]),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var timestamp = (post['timestamp'] as Timestamp).toDate();
    var formattedDate = DateFormat.yMMMd().format(timestamp);

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post['authorName'],
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(formattedDate),
            SizedBox(height: 8.0),
            Text(post['content']),
            SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: _likePost,
                  color: post['likes'].contains(_auth.currentUser?.uid)
                      ? Colors.blue
                      : Colors.grey,
                ),
                Text('${post['likes'].length} likes'),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentsPage(post.id)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  final String postId;
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CommentsPage(this.postId);

  void _postComment() async {
    if (_commentController.text.isNotEmpty) {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .add({
          'authorId': user.uid,
          'authorName': userDoc['name'],
          'content': _commentController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _commentController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('posts')
                  .doc(postId)
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                var comments = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return ListTile(
                      title: Text(comment['authorName']),
                      subtitle: Text(comment['content']),
                      trailing: Text(DateFormat.yMMMd().format(
                          (comment['timestamp'] as Timestamp).toDate())),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Write a comment',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _postComment,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InboxPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          var users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        receiverId: user.id,
                        receiverName: user['name'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  ChatPage({required this.receiverId, required this.receiverName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('messages').add({
          'senderId': user.uid,
          'receiverId': widget.receiverId,
          'message': _messageController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiverName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .where('senderId', isEqualTo: _auth.currentUser?.uid)
                  .where('receiverId', isEqualTo: widget.receiverId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return ListTile(
                      title: Text(message['message']),
                      subtitle: Text(DateFormat('h:mm a')
                          .format(message['timestamp'].toDate())),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Write a message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
