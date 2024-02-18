import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_screen.dart';

class InputScreen extends StatelessWidget {
  // Controllers for the text input fields
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Monitor'),
        backgroundColor: Color.fromARGB(255, 109, 136, 198),
        toolbarHeight: 80.0, 
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 171, 183, 208), 
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildInputFieldsBox(),
              SizedBox(height: 16.0),
              _buildGuidelinesBox(),
            ],
          ),
        ),
      ),
    );
  }

 // Widget for the input fields box
  Widget _buildInputFieldsBox() {
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
            'Enter Values',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          _buildDataEntryField('Systolic value', systolicController),
          
          SizedBox(height: 16.0),
          _buildDataEntryField('Diastolic value', diastolicController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              int? systolic = int.tryParse(systolicController.text);
              int? diastolic = int.tryParse(diastolicController.text);

              if (_isValidInput(systolic, diastolic)) {
                Get.to(InfoScreen(
                  systolic: systolic!,
                  diastolic: diastolic!,
                ));
              } else {
                // Handle invalid input, show alert, GetX snackbar to show a message
                Get.snackbar('Error', 'Invalid input. Please enter valid numbers.');
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 126, 170, 232), 
            ),
            child: Text(
              'Show Details',
              style: TextStyle(color: Colors.black), 
            ),
          ),
        ],
      ),
    );
  }

 // Widget for individual data entry field
  Widget _buildDataEntryField(String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          int? enteredValue = int.tryParse(value);
          if (enteredValue != null) {
            // Additional checks for unreasonable values
            if (enteredValue < 0) {
              //Error messages
              Get.snackbar(
                'Error',
                'Negative values are not allowed.',
                snackStyle: SnackStyle.FLOATING,
                backgroundColor: Color.fromARGB(255, 212, 115, 109), 
                colorText: Colors.white, 
              );
            } else if (enteredValue > 250) {
              Get.snackbar(
                'Error',
                'Entered value is too high.',
                snackStyle: SnackStyle.FLOATING,
                backgroundColor: Color.fromARGB(255, 218, 111, 103), 
                colorText: Colors.white, 
              );
            }
          }
        },
      ),
    ],
  );
}

 // Widget for displaying guidelines box
  Widget _buildGuidelinesBox() {
  return Container(
    width: 700.0, 
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: Color.fromARGB(255, 219, 226, 239),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your blood pressure is recorded as two numbers:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '1. Systolic blood pressure  – indicates how much pressure your blood is exerting against your artery walls when the heart contracts.',
          style: TextStyle(fontSize: 12.0),
        ),
        SizedBox(height: 8.0),
        Text(
          '2. Diastolic blood pressure  – indicates how much pressure your blood is exerting against your artery walls while the heart muscle is resting between contractions.',
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    ),
  );
}

 // Helper method to check if the blood pressure value is valid
  bool _isValidPressureValue(int value) {
    return value >= 0 && value <= 250;
  }

// Helper method to check if the input is valid
  bool _isValidInput(int? systolic, int? diastolic) {
    return systolic != null && diastolic != null && _isValidPressureValue(systolic) && _isValidPressureValue(diastolic);
  }

}
