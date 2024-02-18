import 'package:flutter/material.dart';
//this is info screen that shows the type of blood pressure

class InfoScreen extends StatelessWidget {
  final int systolic;
  final int diastolic;

  InfoScreen({required this.systolic, required this.diastolic});

  String determineCategory() { //This is the logic that decides the level of blood pressure accroding to the entered values
  if (systolic <= 120 && diastolic <= 80) {
    return 'Normal';
  } else if (systolic > 120 && systolic < 130 && diastolic < 80) {
    return 'Elevated';
  } else if (systolic >= 130 && systolic < 140 && diastolic >= 80 && diastolic < 90) {
    return 'Hypertension Stage 1';
  } else if (systolic >= 140 && diastolic >= 90 && systolic < 180) {
    return 'Hypertension Stage 2';
  } else if (systolic >= 180 || diastolic >= 120) {
    return 'Hypertensive Crisis! Needs Immediate Medical Attention';
  } else {
    return 'Invalid Blood Pressure Values';
  }
}

  @override
  Widget build(BuildContext context) {
    String category = determineCategory(); // Get the blood pressure category

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Info'),
        backgroundColor: Color.fromARGB(255, 109, 136, 198),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 171, 183, 208), 
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildEnteredValuesBox(), // Display entered values
            SizedBox(height: 16.0),
            _buildCategoryInfoBox(category),// Display blood pressure category information
            SizedBox(height: 16.0),
            _buildChartImage(), // Display a chart image
          ],
        ),
      ),
      
    );
  }

// Widget for displaying entered values
  Widget _buildEnteredValuesBox() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color.fromARGB(255, 219, 226, 239),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Entered Values',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          // Display systolic and diastolic values
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDataBox('Systolic Value', systolic),
              SizedBox(width: 16.0),
              _buildDataBox('Diastolic Value', diastolic),
            ],
          ),
        ],
      ),
    );
  }

// Widget for displaying blood pressure category information
  Widget _buildCategoryInfoBox(String category) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color.fromARGB(255, 219, 226, 239),
      ),
      child: Center(
        child: Text(
          'Blood Pressure Category: $category',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

// Widget for displaying data in a box
  Widget _buildDataBox(String label, int value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 4.0),
          Text(
            value.toString(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

 // Widget for displaying a chart image
  Widget _buildChartImage() {
    return Image.asset(
      'Images/chart.png',
      height: 250.0,
    );
  }
}
