import 'package:flutter/material.dart';
import 'package:geotech_directorate_page/main.dart';
import 'lower_layer_screen.dart';

class NextScreen3 extends StatefulWidget {
  const NextScreen3({super.key});

  @override
  _NextScreen3State createState() => _NextScreen3State();
}

class _NextScreen3State extends State<NextScreen3> {
  final _formKey = GlobalKey<FormState>();
  final ev2Controller = TextEditingController();
  final nvalueController = TextEditingController();
  final cuController = TextEditingController();

  Color ev2Color = Colors.black;
  Color nvalueColor = Colors.black;
  Color cuColor = Colors.black;

  String validationMessage = '';

  @override
  void initState() {
    super.initState();
    ev2Controller.addListener(() => _validateInput(ev2Controller, 'Ev2'));
    nvalueController.addListener(() => _validateInput(nvalueController, 'nvalue'));
    cuController.addListener(() => _validateInput(cuController, 'Cu'));
  }

  @override
  void dispose() {
    ev2Controller.dispose();
    nvalueController.dispose();
    cuController.dispose();
    super.dispose();
  }

  void _validateInput(TextEditingController controller, String field) {
    setState(() {
      if (field == 'Ev2') {
        final value = double.tryParse(controller.text);
        if (value != null && value >= 20) {
          ev2Color = Colors.green;
        } else {
          ev2Color = Colors.red;
        }
      } else if (field == 'nvalue') {
        final value = int.tryParse(controller.text);
        if (value != null && value >= 5) {
          nvalueColor = Colors.green;
        } else {
          nvalueColor = Colors.red;
        }
      } else if (field == 'Cu') {
        final value = double.tryParse(controller.text);
        if (value != null && value >= 25) {
          cuColor = Colors.green;
        } else {
          cuColor = Colors.red;
        }
      }
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final double ev2 = double.parse(ev2Controller.text);
      final double nvalue = double.parse(nvalueController.text);
      final double cu = double.parse(cuController.text);

      if (ev2 >= 20 && nvalue >= 5 && cu >= 25 ) {
        validationMessage = 'Ground Improvement not required';
        _showValidationDialog(validationMessage, true);
      } else {
        setState(() {
          validationMessage = 'Ground Improvement required';
        });
        _showValidationDialog(validationMessage, false);
      }
    }
  }

  void _showValidationDialog(String message, bool navigate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validation Result'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (navigate) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LowerSoilEntryPage()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.04;
    double fieldWidth = screenWidth * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Test Entry'),
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
        padding: EdgeInsets.all(padding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '((Ev2 >= 20) and (nvalue >= 5) and (Undrained Cohesion(Cu) >= 25))',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                ev2Controller,
                'Ev2',
                'Ev2 should be >= 20',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) < 20) {
                    return 'Ev2 should be >= 20';
                  }
                  return null;
                },
                ev2Color,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                nvalueController,
                'nvalue',
                'nvalue should be >= 5',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || int.tryParse(value) == null || int.parse(value) < 5) {
                    return 'nvalue should be >= 5';
                  }
                  return null;
                },
                nvalueColor,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                cuController,
                'Undrained Cohesion(Cu)',
                'Cu should be >= 25',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) < 25) {
                    return 'Cu should be >= 25';
                  }
                  return null;
                },
                cuColor,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                validationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: validationMessage == 'Ground Improvement required'
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                'Ev2 is to be determined as per para 2.0 of Appendix-H of comprehensive guideline\n'
                    'N value is to be determined by Standard Penetration test as per IS:2131\n'
                    'Undrained Cohesion(Cu) is to be determined from UCC test as per IS:2720 Pt.10',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      String hintText,
      IconData icon,
      FormFieldValidator<String> validator,
      Color color,
      double width,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: width,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyle(color: color),
                prefixIcon: Icon(icon),
              ),
              validator: validator,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const NextScreen3(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
