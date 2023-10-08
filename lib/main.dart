import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tablecalendar/calendar_screen.dart';

void main() {
  runApp(const MyApp());
  Intl.defaultLocale = 'pt_BR';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('pt_BR')],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}

