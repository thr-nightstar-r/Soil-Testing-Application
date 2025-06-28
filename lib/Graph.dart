import 'package:flutter/material.dart';
import 'package:geotech_directorate_page/main.dart';
import 'fl_chart.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    '40 mm': TextEditingController(text: "100"),
    '20 mm': TextEditingController(),
    '10 mm': TextEditingController(),
    '4.75 mm': TextEditingController(),
    '2 mm': TextEditingController(),
    '6 mm': TextEditingController(),
    '.425 mm': TextEditingController(),
    '.212 mm': TextEditingController(),
    '.075 mm': TextEditingController(),
  };

  final Map<String, String> _percentagePassing = {
    '40 mm': '100 weight',
    '20 mm': '80-100 weight',
    '10 mm': '63-85 weight',
    '4.75 mm': '42-68 weight',
    '2 mm': '27-52 weight',
    '6 mm': '13-35 weight',
    '.425 mm': '10-32 weight',
    '.212 mm': '6-22 weight',
    '.075 mm': '3-10 weight',
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final List<double> x2 = _controllers.values.map((controller) => double.tryParse(controller.text) ?? 0).toList();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LineChartSimple(x3: x2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradation Percentage of Blanket Material'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Is Sieve Size',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: _controllers.keys.map((key) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(key),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: _controllers[key],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: _percentagePassing[key],
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NextScreen(),
  ));
}
