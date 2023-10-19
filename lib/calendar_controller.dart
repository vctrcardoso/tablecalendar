import 'package:flutter/material.dart';
import 'package:tablecalendar/config/app_data.dart' as appdata;

class CalendarController extends ChangeNotifier {
  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;

  List<Event> _selectedEvents = [];
  List<Event> get selectedEvents => _selectedEvents;

  Map<DateTime, List<Event>> events = {};

  CalendarController() {
    getEvents();
    setSelectedDay(focusedDay);
    notifyListeners();
  }

  void setSelectedDay(DateTime date) {
    _selectedDay = date;
    notifyListeners();
  }

  void setFocusedDay(DateTime date) {
    _focusedDay = date;
    notifyListeners();
  }

  void getEvents() {
    for (var event in appdata.eventsData) {
      (events[event.dateInitial] ??= []).add(event);
    }
    notifyListeners();
  }

  void setEvents(List<Event> events) {
    _selectedEvents = events;
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime date) {
    return events[date] ?? [];
  }
}

class Event {
  String title;
  DateTime dateInitial;

  Event({required this.title, required this.dateInitial});
}
