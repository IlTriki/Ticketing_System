import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({Key? key}) : super(key: key);

  @override
  State<ProgrammePage> createState() => _ProgrammePageState();
}



class _ProgrammePageState extends State<ProgrammePage> {
  Map<DateTime, List> _eventsList = {};

  DateTime _focused = DateTime.now();
  DateTime? _selected;
  late CalendarFormat _calendarFormat;
    
  

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selected = _focused;
    _eventsList = {
      DateTime.now().subtract(const Duration(days: 2)): ['Test A', 'Test B'],
      DateTime.now(): ['Test C', 'Test D', 'Test E', 'Test F'],
    };
  }

  @override
  Widget build(BuildContext context) {
    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEvent(DateTime day) {
      return events[day] ?? [];
    }

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 4, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            eventLoader: getEvent,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
                setState(() {
                _calendarFormat = format;
                });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selected, day);
            },
            onDaySelected: (selected, focused) {
              if (!isSameDay(_selected, selected)) {
                setState(() {
                  _selected = selected;
                  _focused = focused;
                });
              }
            },
            focusedDay: _focused,
          ),
          ListView(
            shrinkWrap: true,
            children: getEvent(_selected!)
                .map((event) => ListTile(
                      title: Text(event.toString()),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
