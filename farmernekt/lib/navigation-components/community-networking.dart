import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class CommunityNetworkingPage extends StatefulWidget {
  @override
  _CommunityNetworkingPageState createState() =>
      _CommunityNetworkingPageState();
}

class _CommunityNetworkingPageState extends State<CommunityNetworkingPage> {
  List<Post> posts = [
    Post(
      title: 'Crop Rotation Tips',
      content:
          'Learn about effective crop rotation techniques to improve soil health.',
      imagePath: 'assets/images/crop_rotation.jpg',
    ),
    Post(
      title: 'Organic Pest Control',
      content: 'Discover natural methods to control pests in your garden.',
      imagePath: 'assets/images/organic_pest_control.jpg',
    ),
    Post(
      title: 'Composting Basics',
      content: 'Start composting to enrich your soil and reduce waste.',
      imagePath: 'assets/images/composting_basics.jpg',
    ),
  ];

  void addPost(Post post) {
    setState(() {
      posts.add(post);
    });
  }

  void toggleLike(Post post) {
    setState(() {
      post.isLiked = !post.isLiked;
      post.isLiked ? post.likeCount++ : post.likeCount--;
    });
  }

  void addComment(Post post, String comment) {
    setState(() {
      post.comments.add(comment);
    });
  }

  bool _isPostFormVisible = false;
  bool _isDMVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmers Community Network'),
        backgroundColor: Colors.green[700],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[700],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Posts'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPostFormVisible = !_isPostFormVisible;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                _isPostFormVisible ? Icons.remove : Icons.add,
                                color: Colors.green[900],
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Share your thoughts',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_isPostFormVisible) ...[
                          SizedBox(height: 16.0),
                          PostForm(addPost: addPost),
                        ],
                        SizedBox(height: 16.0),
                        Text(
                          'Community Posts',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Column(
                          children: posts.map((post) {
                            return PostTile(
                              post: post,
                              onLike: () => toggleLike(post),
                              onComment: (comment) => addComment(post, comment),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.0,
            color: Colors.grey[300],
          ),
          Expanded(
            flex: _isDMVisible ? 1 : 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDMVisible = !_isDMVisible;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isDMVisible
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.green[900],
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Direct Messages',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isDMVisible)
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[700],
                            child: Text('A'),
                          ),
                          title: Text('Alice'),
                          subtitle: Text('How are the crops?'),
                          onTap: () {
                            // Implement message navigation
                          },
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[700],
                            child: Text('B'),
                          ),
                          title: Text('Bob'),
                          subtitle: Text('Need help with irrigation.'),
                          onTap: () {
                            // Implement message navigation
                          },
                        ),
                        // Add more ListTile for other messages
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostForm extends StatefulWidget {
  final Function(Post) addPost;

  PostForm({required this.addPost});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      });
    } else {
      // Handle permission denied case
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[700]!),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: 'Content',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[700]!),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some content';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          _imageFile == null
              ? Text('No image selected.')
              : Image.file(_imageFile!, height: 200),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              primary: Colors.green[700],
            ),
            child: Text('Select Image'),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final post = Post(
                  title: _titleController.text,
                  content: _contentController.text,
                  imagePath: _imageFile?.path,
                );
                widget.addPost(post);
                _titleController.clear();
                _contentController.clear();
                setState(() {
                  _imageFile = null;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green[700],
            ),
            child: Text('Add Post'),
          ),
        ],
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final Function(String) onComment;

  const PostTile({
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              post.content,
              style: TextStyle(fontSize: 16),
            ),
            if (post.imagePath != null) ...[
              SizedBox(height: 8.0),
              Image.file(
                File(post.imagePath!),
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? Colors.red : null,
                  ),
                  onPressed: onLike,
                ),
                Text('${post.likeCount}'),
              ],
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment...',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[700]!),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Colors.green[700]),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      onComment(_commentController.text);
                      _commentController.clear();
                    }
                  },
                ),
              ),
            ),
            ...post.comments.map((comment) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(comment),
                )),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String title;
  final String content;
  final String? imagePath;
  bool isLiked;
  int likeCount;
  List<String> comments;

  Post({
    required this.title,
    required this.content,
    this.imagePath,
    this.isLiked = false,
    this.likeCount = 0,
    this.comments = const [],
  });
}
