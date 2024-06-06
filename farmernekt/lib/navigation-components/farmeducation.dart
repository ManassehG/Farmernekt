import 'package:flutter/material.dart';

class EducationalContentPage extends StatefulWidget {
  @override
  _EducationalContentPageState createState() => _EducationalContentPageState();
}

class _EducationalContentPageState extends State<EducationalContentPage> {
  String _selectedFilter = 'All';

  final List<EducationalTopic> _allTopics = [
    EducationalTopic(
      title: 'Crop Rotation',
      description:
          'Crop rotation involves changing the type of crop grown in a particular field from season to season. This helps prevent soil depletion, reduce pest and disease problems, and improve soil health.',
      detailedInfo: '''
Step-by-Step Guide:
1. Identify crop families and group crops into families.
2. Plan a rotation schedule, ensuring that crops from the same family do not follow each other.
3. Implement the rotation plan and adjust based on observations and soil tests.

Examples of Crop Rotation Schedules:
- Year 1: Corn
- Year 2: Soybeans
- Year 3: Wheat
- Year 4: Clover
      ''',
      type: 'Crop-related',
    ),
    EducationalTopic(
      title: 'Organic Farming',
      description:
          'Organic farming uses natural methods to grow crops and raise livestock. This includes composting, natural pest control, and avoiding synthetic fertilizers and pesticides.',
      detailedInfo: '''
Techniques for Soil Enrichment:
1. Composting: Use organic waste to create compost that enriches soil.
2. Green Manure: Grow cover crops to add nutrients to the soil.
3. Crop Rotation: Rotate crops to maintain soil health.

Natural Pest Control Methods:
1. Beneficial Insects: Introduce insects that prey on pests.
2. Crop Diversity: Grow a variety of crops to reduce pest outbreaks.
3. Neem Oil: Use neem oil as a natural pesticide.

Case Studies:
1. Green Valley Organic Farm: Improved soil health and yield through composting and crop rotation.
2. Sunny Acres: Reduced pest issues with natural predators and diverse planting.
      ''',
      type: 'Crop-related',
    ),
    EducationalTopic(
      title: 'Animal Husbandry',
      description:
          'Animal husbandry involves the care, breeding, and management of livestock. This includes proper feeding, housing, and health care to ensure the well-being and productivity of animals.',
      detailedInfo: '''
Breeding Guidelines:
1. Select healthy and high-quality breeding stock.
2. Implement a breeding schedule to optimize reproductive cycles.
3. Monitor and record breeding results to improve future breeding decisions.

Feeding Practices:
1. Provide a balanced diet specific to the species and age of the animals.
2. Ensure access to clean water at all times.
3. Supplement feed with vitamins and minerals as needed.

Health Monitoring:
1. Regular veterinary check-ups and vaccinations.
2. Monitor for signs of illness and isolate sick animals.
3. Maintain clean and hygienic living conditions.

Best Practices for Housing:
1. Provide adequate space and shelter for all animals.
2. Ensure proper ventilation and temperature control.
3. Use appropriate bedding materials and clean regularly.
      ''',
      type: 'Livestock-related',
    ),
    EducationalTopic(
      title: 'Pest Management',
      description:
          'Pest management involves strategies to control pests in agriculture. This can include biological controls, chemical treatments, and integrated pest management techniques.',
      detailedInfo: '''
Identification of Common Pests:
1. Aphids: Small, soft-bodied insects that feed on plant sap.
2. Caterpillars: Larvae of butterflies and moths that chew on leaves.
3. Weevils: Beetles that infest stored grains and seeds.

Integrated Pest Management (IPM) Methods:
1. Biological Control: Use natural predators like ladybugs to control aphids.
2. Cultural Control: Rotate crops and use resistant varieties.
3. Mechanical Control: Hand-pick pests and use traps.
4. Chemical Control: Use pesticides as a last resort and follow guidelines.

Case Studies:
1. Riverbend Farm: Successfully reduced pest damage using IPM techniques.
2. Orchard Hill: Implemented biological control methods to manage pest populations.
      ''',
      type: 'Crop-related',
    ),
    EducationalTopic(
      title: 'Dairy Farming',
      description:
          'Dairy farming focuses on milk production from dairy animals. This includes proper nutrition, milking techniques, and maintaining herd health.',
      detailedInfo: '''
Feeding and Nutrition:
1. Provide a balanced diet with a mix of forages, grains, and supplements.
2. Ensure access to fresh water at all times.
3. Monitor feed intake and adjust rations based on production needs.

Milking Techniques:
1. Clean udders and equipment before milking.
2. Use proper milking procedures to ensure hygiene and milk quality.
3. Store milk at the correct temperature to maintain freshness.

Herd Health Management:
1. Schedule regular veterinary visits for health check-ups and vaccinations.
2. Monitor cows for signs of illness or stress.
3. Maintain clean and comfortable housing to reduce disease risk.
      ''',
      type: 'Livestock-related',
    ),
    EducationalTopic(
      title: 'Soil Health',
      description:
          'Maintaining soil health is crucial for sustainable farming. This involves practices like composting, crop rotation, and soil testing to ensure nutrient balance and soil structure.',
      detailedInfo: '''
Improving Soil Fertility:
1. Use organic matter like compost and manure to enrich soil.
2. Implement crop rotation to prevent nutrient depletion.
3. Plant cover crops to add organic matter and improve soil structure.

Soil Testing Methods:
1. Collect soil samples from different areas of the field.
2. Send samples to a lab for analysis.
3. Use results to adjust fertilization and soil management practices.

Interpreting Soil Test Results:
1. pH Levels: Ensure soil pH is within the optimal range for crops.
2. Nutrient Levels: Identify deficiencies and apply appropriate fertilizers.
3. Organic Matter: Aim to increase organic matter for better soil health.
      ''',
      type: 'Crop-related',
    ),
    EducationalTopic(
      title: 'Poultry Farming',
      description:
          'Poultry farming involves raising chickens, ducks, and other birds for meat and eggs. This includes managing housing, feeding, and health care to ensure productive flocks.',
      detailedInfo: '''
Setting Up a Poultry Farm:
1. Choose a suitable location with adequate space and ventilation.
2. Construct housing with proper lighting, bedding, and nesting boxes.
3. Install feeding and watering systems.

Feeding Practices:
1. Provide a balanced diet with grains, protein, and vitamins.
2. Ensure access to clean water at all times.
3. Use feeders and waterers to prevent contamination.

Health and Disease Management:
1. Vaccinate birds against common diseases.
2. Monitor flocks for signs of illness and isolate affected birds.
3. Maintain clean and hygienic housing to reduce disease risk.

Maximizing Egg Production:
1. Provide adequate lighting to stimulate laying.
2. Ensure proper nutrition and health care.
3. Collect eggs regularly to maintain cleanliness and quality.
      ''',
      type: 'Livestock-related',
    ),
  ];

  late List<EducationalTopic> _filteredTopics;

  @override
  void initState() {
    super.initState();
    _filteredTopics = _allTopics;
  }

  void _filterTopics(String? filter) {
    setState(() {
      _selectedFilter = filter ?? 'All';
      if (filter == 'All') {
        _filteredTopics = _allTopics;
      } else {
        _filteredTopics =
            _allTopics.where((topic) => topic.type == filter).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Content'),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: _selectedFilter,
                  elevation: 5,
                  items: <String>['All', 'Crop-related', 'Livestock-related']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: _filterTopics,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredTopics.length,
                  itemBuilder: (context, index) {
                    return _buildEducationalCard(
                        context, _filteredTopics[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationalCard(BuildContext context, EducationalTopic topic) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          topic.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          topic.description,
          style: TextStyle(color: Colors.black54),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EducationalDetailPage(topic: topic),
            ),
          );
        },
      ),
    );
  }
}

class EducationalDetailPage extends StatelessWidget {
  final EducationalTopic topic;

  EducationalDetailPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                topic.description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Text(
                topic.detailedInfo,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EducationalTopic {
  final String title;
  final String description;
  final String detailedInfo;
  final String type;

  EducationalTopic({
    required this.title,
    required this.description,
    required this.detailedInfo,
    required this.type,
  });
}
