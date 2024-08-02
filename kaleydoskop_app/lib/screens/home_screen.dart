import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100, 
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  
                    Image.asset(
                      'assets/kaleidoscope.png', 
                      height: 100, 
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kaleydoskop',
                      style: GoogleFonts.urbanist(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, 
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2, 
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20),
                    _buildCard(
                      context,
                      'Uyumsuz Gündüz Düşü Nedir?',
                      FontAwesomeIcons.infoCircle,
                      '/info_and_motivation',
                      Colors.teal.shade100, 
                      Colors.teal.shade700, 
                    ),
                    SizedBox(height: 20),
                    _buildCard(
                      context,
                      'Uyumsuz Gündüz Düşü Ölçeği (MDS-16)',
                      FontAwesomeIcons.chartLine,
                      '/test',
                      Colors.orange.shade100, 
                      Colors.orange.shade700, 
                    ),
                    SizedBox(height: 20),
                    _buildCard(
                      context,
                      'Düş Günlüğü',
                      FontAwesomeIcons.bookOpen,
                      '/dream_diary',
                      Color.fromARGB(255, 213, 159, 159), 
                      Color.fromARGB(255, 158, 97, 97), 
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildCard(
    BuildContext context,
    String title, 
    IconData icon, 
    String route, 
    Color backgroundColor, 
    Color iconColor, 
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); 
      },
      child: Card(
        color: Colors.white, 
        elevation: 8, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundColor.withOpacity(0.1), Colors.white], 
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: backgroundColor, 
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(icon, color: iconColor, size: 30), // Simge
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 16, 
                      fontWeight: FontWeight.w500,
                      color: Colors.black87, 
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 22), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}