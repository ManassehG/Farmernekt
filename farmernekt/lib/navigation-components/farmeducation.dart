import 'package:flutter/material.dart';

class EducationalContentPage extends StatefulWidget {
  @override
  _EducationalContentPageState createState() => _EducationalContentPageState();
}

class _EducationalContentPageState extends State<EducationalContentPage> {
  // List of education topics
  final List<Map<String, String>> _educationTopics = [
    {
      'title': 'Crop Rotation',
      'description':
          'Learn about the benefits and techniques of crop rotation.',
      'category': 'Crop Farming'
    },
    {
      'title': 'Organic Farming',
      'description': 'Discover methods of sustainable and organic farming.',
      'category': 'Crop Farming'
    },
    {
      'title': 'Animal Husbandry',
      'description': 'Get insights into effective animal care and management.',
      'category': 'Livestock Farming'
    },
    {
      'title': 'Pest Management',
      'description': 'Understand strategies for controlling pests in farming.',
      'category': 'Crop Farming'
    },
    {
      'title': 'Dairy Farming',
      'description':
          'Learn the best practices for dairy farming and milk production.',
      'category': 'Livestock Farming'
    },
    {
      'title': 'Soil Health',
      'description': 'Explore ways to maintain and improve soil health.',
      'category': 'Crop Farming'
    },
    {
      'title': 'Poultry Farming',
      'description':
          'Find out how to manage and maintain a successful poultry farm.',
      'category': 'Livestock Farming'
    },
  ];

  String _selectedCategory = 'All';

  List<Map<String, String>> get _filteredTopics {
    if (_selectedCategory == 'All') {
      return _educationTopics;
    } else {
      return _educationTopics
          .where((topic) => topic['category'] == _selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['All', 'Crop Farming', 'Livestock Farming']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTopics.length,
                itemBuilder: (context, index) {
                  final topic = _filteredTopics[index];
                  return Card(
                    color: _getRandomColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(
                        topic['title']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        topic['description']!,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get a random color for each card
  Color _getRandomColor() {
    List<Color> colors = [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.tealAccent,
    ];
    colors.shuffle();
    return colors.first;
  }
}
