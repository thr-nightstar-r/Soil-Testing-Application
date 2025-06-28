import 'package:flutter/material.dart';
import 'package:geotech_directorate_page/main.dart';
import 'Top_Layer.dart';

class LowerSoilEntryPage extends StatefulWidget {
  const LowerSoilEntryPage({super.key});

  @override
  _LowerSoilEntryPageState createState() => _LowerSoilEntryPageState();
}

class _LowerSoilEntryPageState extends State<LowerSoilEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final finesController = TextEditingController();
  final cbrController = TextEditingController();

  Color finesColor = Colors.black;
  Color cbrColor = Colors.black;

  String validationMessage = '';

  @override
  void initState() {
    super.initState();
    finesController.addListener(() => _validateInput(finesController, 'Fines'));
    cbrController.addListener(() => _validateInput(cbrController, 'CBR'));
  }

  @override
  void dispose() {
    finesController.dispose();
    cbrController.dispose();
    super.dispose();
  }

  void _validateInput(TextEditingController controller, String field) {
    setState(() {
      if (field == 'Fines') {
        final value = int.tryParse(controller.text);
        if (value != null && value <= 100) {
          finesColor = Colors.green;
        } else {
          finesColor = Colors.red;
        }
      } else if (field == 'CBR') {
        final value = double.tryParse(controller.text);
        if (value != null && value >= 3) {
          cbrColor = Colors.green;
        } else {
          cbrColor = Colors.red;
        }
      }
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final int fines = int.parse(finesController.text);
      final double cbr = double.parse(cbrController.text);

      if (fines <= 100 && cbr >= 3) {
        validationMessage =
            'soil use in lower fill is ok and soil type is SQ1. Top Layer Thickness 100cm required';
        _showValidationDialog(validationMessage, true);
      } else {
        setState(() {
          validationMessage = 'Better quality Soil required';
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Toplayer()),
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
        title: const Text('Lower Soil Entry'),
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
                  '(fines <= 100, CBR >= 3, MDD = 97)',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                finesController,
                'Fines (in %)',
                'Fines should be <= 100',
                Icons.linear_scale_rounded,
                (value) {
                  if (value == null ||
                      double.parse(value) == Null ||
                      double.parse(value) > 100) {
                    return 'Fines should be <= 100';
                  }
                  return null;
                },
                finesColor,
                fieldWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                cbrController,
                'CBR',
                'CBR should be >= 3',
                Icons.linear_scale_rounded,
                (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) > 3) {
                    return 'CBR should be >= 3';
                  }
                  return null;
                },
                cbrColor,
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
    home: const LowerSoilEntryPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
