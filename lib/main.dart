import 'package:flutter/material.dart';
import 'Graph.dart';
import 'lower_layer_screen.dart';
import 'Suitability_of_subsoil.dart';
import 'Top_Layer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.greenAccent,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isHovered1 = false;
  bool _isHovered2 = false;
  bool _isHovered3 = false;

  void _navigateTo(BuildContext context, Widget screen) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigation error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Geotech Directorate',
          style: TextStyle(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 10,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: screenWidth * 0.06),
            color: Colors.white,
            onPressed: () {
              // Handle the bell icon press here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications pressed')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Blanket Thickness Calculation',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Image.asset(
                  'assets/your_image.png',
                  height: screenHeight * 0.25,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not found', style: TextStyle(color: Colors.red));
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildMenuButton(
                context,
                'Suitability of Sub soil Ground Soil',
                _isHovered1,
                    () => setState(() => _isHovered1 = !_isHovered1),
                    () => _navigateTo(context, const NextScreen3()),
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildMenuButton(
                context,
                'Properties Of Lower Level Fill',
                _isHovered2,
                    () => setState(() => _isHovered2 = !_isHovered2),
                    () => _navigateTo(context, const LowerSoilEntryPage()),
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildMenuButton(
                context,
                'Properties of Top Layer(Fill)',
                _isHovered3,
                    () => setState(() => _isHovered3 = !_isHovered3),
                    () => _navigateTo(context, const Toplayer()),
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildMenuButton(
                context,
                'Graph',
                _isHovered3,
                    () => setState(() => _isHovered3 = !_isHovered3),
                    () => _navigateTo(context, NextScreen()),
                screenWidth,
                screenHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context,
      String text,
      bool isHovered,
      VoidCallback onHover,
      VoidCallback onPressed,
      double screenWidth,
      double screenHeight,
      ) {
    return Center(
      child: MouseRegion(
        onEnter: (_) => onHover(),
        onExit: (_) => onHover(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isHovered ? screenWidth * 0.8 : screenWidth * 0.75,
          height: isHovered ? screenHeight * 0.08 : screenHeight * 0.07,
          decoration: BoxDecoration(
            color: isHovered ? Colors.blueAccent : Colors.blue,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0.2,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
