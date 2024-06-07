import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FarmManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm Management'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        color: Colors.green[50], // Background color
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardOverview(),
              SizedBox(height: 16.0),
              CropManagement(),
              SizedBox(height: 16.0),
              LivestockManagement(),
              SizedBox(height: 16.0),
              InventoryManagement(),
              SizedBox(height: 16.0),
              TaskManagement(),
              SizedBox(height: 16.0),
              FinancialManagement(),
              SizedBox(height: 16.0),
              WeatherForecast(),
              SizedBox(height: 16.0),
              ReportsAndAnalytics(),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.grass, color: Colors.green[800]),
                SizedBox(width: 8.0),
                Text('Total Crops: 150', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.pets, color: Colors.brown[800]),
                SizedBox(width: 8.0),
                Text('Total Livestock: 75', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.task, color: Colors.blue[800]),
                SizedBox(width: 8.0),
                Text('Tasks Today: 5', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CropManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Crop Management',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            CropTile(
                cropName: 'Wheat', growthStage: 'Harvesting', yield: '200kg'),
            CropTile(cropName: 'Corn', growthStage: 'Sowing', yield: '150kg'),
            CropTile(cropName: 'Rice', growthStage: 'Growing', yield: '300kg'),
          ],
        ),
      ),
    );
  }
}

class LivestockManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Livestock Management',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            LivestockTile(
                livestockType: 'Cows', healthStatus: 'Good', count: 50),
            LivestockTile(
                livestockType: 'Sheep', healthStatus: 'Average', count: 25),
          ],
        ),
      ),
    );
  }
}

class InventoryManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inventory Management',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            InventoryTile(itemName: 'Seeds', quantity: '100kg'),
            InventoryTile(itemName: 'Fertilizers', quantity: '200kg'),
            InventoryTile(itemName: 'Pesticides', quantity: '50 liters'),
          ],
        ),
      ),
    );
  }
}

class TaskManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Management',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            TaskTile(
                taskDescription: 'Water the crops',
                dueDate: DateTime.now().add(Duration(days: 1))),
            TaskTile(
                taskDescription: 'Feed the livestock',
                dueDate: DateTime.now().add(Duration(days: 2))),
            TaskTile(
                taskDescription: 'Harvest wheat',
                dueDate: DateTime.now().add(Duration(days: 3))),
          ],
        ),
      ),
    );
  }
}

class FinancialManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Financial Management',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            FinancialTile(description: 'Seeds Purchase', amount: 500.0),
            FinancialTile(description: 'Fertilizer Purchase', amount: 300.0),
            FinancialTile(description: 'Livestock Sale', amount: 1500.0),
          ],
        ),
      ),
    );
  }
}

class WeatherForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weather Forecast',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Today: Sunny, 28°C', style: TextStyle(fontSize: 16)),
            Text('Tomorrow: Cloudy, 22°C', style: TextStyle(fontSize: 16)),
            Text('Day after Tomorrow: Rainy, 20°C',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ReportsAndAnalytics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reports and Analytics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Crop Yield: 2000kg', style: TextStyle(fontSize: 16)),
            Text('Livestock Production: 1500 liters of milk',
                style: TextStyle(fontSize: 16)),
            Text('Total Expenses: \$2000', style: TextStyle(fontSize: 16)),
            Text('Total Revenue: \$5000', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class CropTile extends StatelessWidget {
  final String cropName;
  final String growthStage;
  final String yield;

  CropTile(
      {required this.cropName, required this.growthStage, required this.yield});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(cropName, style: TextStyle(fontSize: 16)),
          Text('Stage: $growthStage', style: TextStyle(fontSize: 16)),
          Text('Yield: $yield', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class LivestockTile extends StatelessWidget {
  final String livestockType;
  final String healthStatus;
  final int count;

  LivestockTile(
      {required this.livestockType,
      required this.healthStatus,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(livestockType, style: TextStyle(fontSize: 16)),
          Text('Health: $healthStatus', style: TextStyle(fontSize: 16)),
          Text('Count: $count', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class InventoryTile extends StatelessWidget {
  final String itemName;
  final String quantity;

  InventoryTile({required this.itemName, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(itemName, style: TextStyle(fontSize: 16)),
          Text('Quantity: $quantity', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String taskDescription;
  final DateTime dueDate;

  TaskTile({required this.taskDescription, required this.dueDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(taskDescription, style: TextStyle(fontSize: 16)),
          Text('Due: ${DateFormat('dd/MM/yyyy').format(dueDate)}',
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class FinancialTile extends StatelessWidget {
  final String description;
  final double amount;

  FinancialTile({required this.description, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(description, style: TextStyle(fontSize: 16)),
          Text('\$$amount', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
