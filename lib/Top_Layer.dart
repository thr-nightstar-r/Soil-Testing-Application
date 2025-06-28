import 'package:flutter/material.dart';
import 'package:geotech_directorate_page/main.dart';
import 'specifications.dart';


class Toplayer extends StatefulWidget {
  const Toplayer({super.key});

  @override
  _ToplayerState createState() => _ToplayerState();
}

class _ToplayerState extends State<Toplayer> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController CBRController = TextEditingController();
  final TextEditingController FinesController = TextEditingController();
  final TextEditingController MDDController = TextEditingController();
  final TextEditingController Ev2Controller = TextEditingController();

  Color CBRColor = Colors.black;
  Color FinesColor = Colors.black;
  Color MDDColor = Colors.black;
  Color Ev2Color = Colors.black;

  String validationMessage = '';

  @override
  void initState() {
    super.initState();
    CBRController.addListener(() => _validateInput(CBRController, 'CBR'));
    FinesController.addListener(() => _validateInput(FinesController, 'Fines'));
    MDDController.addListener(() => _validateInput(MDDController, 'MDD'));
    Ev2Controller.addListener(() => _validateInput(Ev2Controller, 'Ev2'));
  }

  @override
  void dispose() {
    CBRController.dispose();
    FinesController.dispose();
    MDDController.dispose();
    Ev2Controller.dispose();
    super.dispose();
  }

  void _validateInput(TextEditingController controller, String field) {
    setState(() {
      final value = double.tryParse(controller.text);
      switch (field) {
        case 'CBR':
          CBRColor = (value != null && value >= 4) ? Colors.green : Colors.red;
          break;
        case 'Fines':
          final intValue = int.tryParse(controller.text);
          FinesColor = (intValue != null && intValue <= 100) ? Colors.green : Colors.red;
          break;
        case 'MDD':
          MDDColor = (value != null && value >= 98) ? Colors.green : Colors.red;
          break;
        case 'Ev2':
          Ev2Color = (value != null && value >= 45) ? Colors.green : Colors.red;
          break;
      }
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final int fines = int.parse(FinesController.text);
      final double mdd = double.parse(MDDController.text);
      final double cbr = double.parse(CBRController.text);
      final double ev2 = double.parse(Ev2Controller.text);

      if (fines >= 50 && fines <= 100 && mdd >= 98 && cbr >= 4 && ev2 >= 45) {
        validationMessage = 'Soil Used For top Layer is ok and type of Soil is SQ1';
      } else if (fines >= 12 && fines <= 49 && mdd >= 98 && cbr >= 6 && ev2 >= 60) {
        validationMessage = 'Soil Used For top Layer is ok and type of Soil is SQ2';
      } else if (fines < 12 && mdd >= 98 && cbr >= 6 && ev2 >= 60) {
        validationMessage = 'Soil Used For top Layer is ok and type of Soil is SQ3';
      } else {
        validationMessage = 'Better Quality Soil is Required';
      }

      _showValidationDialog(validationMessage);
    }
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (message.startsWith('Soil Used For top Layer is ok')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SpecificationPage()),
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
        title: const Text(
          'Top Layer Soil Entry Upto 1 Meter Soil Quality',
          style: TextStyle(fontSize: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
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
                  'Enter the required values: Fines <=100, CBR >=4 or >=6, MDD >=98, Ev2 >=45 or 60',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                CBRController,
                'CBR',
                'CBR should be >=4 or >=6',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) <= 4) {
                    return 'CBR should be >=4 or >=6';
                  }
                  return null;
                },
                CBRColor,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                FinesController,
                'Fines',
                'Fines should be <=100',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || int.tryParse(value) == null || int.parse(value) > 100) {
                    return 'Fines should be <=100';
                  }
                  return null;
                },
                FinesColor,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                MDDController,
                'MDD',
                'MDD should be >= 98',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) < 98) {
                    return 'MDD should be >= 98';
                  }
                  return null;
                },
                MDDColor,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                Ev2Controller,
                'Ev2',
                'Ev2 should be >= 45 or 60',
                Icons.linear_scale_rounded,
                    (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) < 45) {
                    return 'Ev2 should be >= 45 or 60';
                  }
                  return null;
                },
                Ev2Color,
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
                  color: validationMessage == 'Better Quality Soil is Required'
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
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
