import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/info_and_motivation_screen.dart';
import 'screens/test_screen.dart';
import 'screens/dream_diary_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaleydoskop',
      theme: ThemeData(
        primaryColor: Colors.black, 
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          secondary: Colors.blueAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black, 
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/info_and_motivation': (context) => InfoAndMotivationScreen(),
        '/test': (context) => TestScreen(),
        '/dream_diary': (context) => DreamDiaryScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => Scaffold(
          appBar: AppBar(title: Text('404')),
          body: Center(child: Text('Sayfa bulunamadı')),
        ));
      },
    );
  }
}
