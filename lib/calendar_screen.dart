import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Calendar'),
      ),
      body: SafeArea(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          headerStyle: const HeaderStyle(
            titleCentered: true,
          ),
          locale: 'pt_BR',
          calendarStyle: const CalendarStyle(),
          calendarBuilders: CalendarBuilders(
            // headerTitleBuilder: (context, day) {
              
            // },
          ),
        ),
      ),
    );
  }
}
