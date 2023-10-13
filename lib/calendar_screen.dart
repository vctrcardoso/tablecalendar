import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tablecalendar/calendar_controller.dart';
import 'package:tablecalendar/config/colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    super.initState();

    calendarController.setEvents();
    print(calendarController.selectedEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Calendar'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<CalendarController>(
              builder: (context, controller, child) {
                return TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: context.watch<CalendarController>().focusedDay,
                  selectedDayPredicate: (day) => isSameDay(
                      context.watch<CalendarController>().selectedDay, day),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(),
                  eventLoader: (day) => controller.getEventsForDay(day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(controller.selectedDay, selectedDay)) {
                      controller.setSelectedDay(selectedDay);
                      controller.setFocusedDay(focusedDay);
                      controller.setEvents();
                    }
                  },
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      var dayName = DateFormat('EEE').format(day);
                      return Center(
                        child: Text(dayName),
                      );
                    },
                    //  markerBuilder: (context, day, events) {
                    //    events.isNotEmpty ? Container(
                    //      decoration: const BoxDecoration(
                    //        shape: BoxShape.circle,
                    //      ),
                    //      alignment: Alignment.bottomRight,
                    //      child: Text(
                    //        events.length.toString(),
                    //        style: const TextStyle(
                    //          color: Colors.red,
                    //        ),
                    //      ),
                    //    ) : null;
                    //  },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            context.watch<CalendarController>().selectedEvents.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: context
                          .watch<CalendarController>()
                          .selectedEvents
                          .length,
                      itemBuilder: (context, index) {
                        var events =
                            context.watch<CalendarController>().selectedEvents;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 64,
                          width: 24,
                          decoration: const BoxDecoration(
                            color: ColorsConst.appSecondColor,
                            border: Border(
                              left: BorderSide(
                                  color: ColorsConst.appPrimaryColor, width: 6),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(events[index].dateInitial.toString()),
                              Text(events[index].title)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
