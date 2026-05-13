import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  String gender = "Male";
  String result = "";

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (weight == 0 || height == 0) {
      setState(() {
        result = "⚠ Please enter valid values";
      });
      return;
    }

    double bmi = weight / ((height / 100) * (height / 100));

    String status;
    if (bmi < 18.5) {
      status = "Underweight";
    } else if (bmi < 25) {
      status = "Normal";
    } else if (bmi < 30) {
      status = "Overweight";
    } else {
      status = "Obese";
    }

    setState(() {
      result =
      "👤 Gender: $gender\n Age: ${ageController.text}\n BMI: ${bmi.toStringAsFixed(2)}\n Status: $status";
    });
  }

  void clearAll() {
    ageController.clear();
    heightController.clear();
    weightController.clear();

    setState(() {
      gender = "Male";
      result = "";
    });
  }

  Widget inputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  "BMI CALCULATOR",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // AGE
                inputField("Age", ageController),
                const SizedBox(height: 15),

                // GENDER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text("Male"),
                      selected: gender == "Male",
                      onSelected: (_) => setState(() => gender = "Male"),
                    ),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text("Female"),
                      selected: gender == "Female",
                      onSelected: (_) => setState(() => gender = "Female"),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // HEIGHT
                inputField("Height (cm)", heightController),
                const SizedBox(height: 15),

                // WEIGHT
                inputField("Weight (kg)", weightController),

                const SizedBox(height: 25),

                // BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: calculateBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("CALCULATE"),
                    ),
                    ElevatedButton(
                      onPressed: clearAll,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text("CLEAR"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // RESULT CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}