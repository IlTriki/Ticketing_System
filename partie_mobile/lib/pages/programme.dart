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
  Map<DateTime, List> _eventsDescrip = {};
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
      DateTime.now().subtract(const Duration(days: 5)): ['Changement pièce imprimante', 'Maintenance Ecran Open Space'],
      DateTime.now().subtract(const Duration(days: 4)): ['Installation imprimante'],
      DateTime.now().subtract(const Duration(days: 3)): ['Installation imprimante scanner Recoh'],
      DateTime.now().subtract(const Duration(days: 2)): ['Installation écran connecté'],
      DateTime.now().subtract(const Duration(days: 1)): ['Maintenance scanner'],
      DateTime.now(): ['Réparation imprimante'],
      DateTime.now().add(const Duration(days: 1)): ['Maintenance écran intéractif', 'Installation imprimante scanner Recoh'],
      DateTime.now().add(const Duration(days: 2)): ['Maintenance écran intéractif'],
      DateTime.now().add(const Duration(days: 3)): ['Maintenance écran intéractif', 'Installation imprimante scanner Recoh'],
      DateTime.now().add(const Duration(days: 4)): ['Maintenance écran intéractif'],
    };
    _eventsDescrip = {
      DateTime.now().subtract(const Duration(days: 5)): ['Fnac Saint Jacques','12:00 - 16:00', DateTime.now().subtract(const Duration(days: 5)),'Fnac Saint Jacques','12:00 - 16:00', DateTime.now().subtract(const Duration(days: 5))],
      DateTime.now().subtract(const Duration(days: 4)): ['Fnac Saint Jacques','12:00 - 16:00', DateTime.now().subtract(const Duration(days: 4))],
      DateTime.now().subtract(const Duration(days: 3)): ['Fnac Saint Jacques','12:00 - 16:00', DateTime.now().subtract(const Duration(days: 3))],
      DateTime.now().subtract(const Duration(days: 2)): ['Préfecture de Police','12:00 - 16:00', DateTime.now().subtract(const Duration(days: 2))],
      DateTime.now().subtract(const Duration(days: 1)): ['Siège de Google','12:00 - 16:00', DateTime.now().subtract(const Duration(days: 1))],
      DateTime.now(): ['IUT de Metz','15:30 - 16:30', DateTime.now()],
      DateTime.now().add(const Duration(days: 1)): ['Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 1)), 'Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 1)), 'Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 1)), 'Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 1))],
      DateTime.now().add(const Duration(days: 2)): ['Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 2))],
      DateTime.now().add(const Duration(days: 3)): ['Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 3)), 'Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 3))],
      DateTime.now().add(const Duration(days: 4)): ['Siège de Google','12:00 - 16:00', DateTime.now().add(const Duration(days: 4))],
    };
  }

  @override
  Widget build(BuildContext context) {
    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    final eventsDesc = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsDescrip);

    List getEventDesc(DateTime day) {
      return eventsDesc[day] ?? [];
    }

    List getEvent(DateTime day) {
      return events[day] ?? [];
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      tileColor: Color.fromARGB(169, 206, 206, 206),
                      title: Text(event.toString()),
                    ))
                .toList(),
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                    bottom: 30,
                    right: 30,
                    left: 30,
                    top: 20,
              ),
              children: getEventDesc(_selected!)
                .map((event) => ListTile(
                      tileColor: Color.fromARGB(255, 143, 88, 214),
                      title: Text(event.toString()),
                    ))
                .toList(),
            )
        ],
      ),
    ),
    );
  }
}
