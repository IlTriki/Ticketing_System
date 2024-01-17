import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({Key? key}) : super(key: key);

  @override
  State<ProgrammePage> createState() => _ProgrammePageState();
}

class _ProgrammePageState extends State<ProgrammePage> {
  late double screenWidth;
  late List<Ticket> _tickets;
  DateTime _focused = DateTime.now();
  DateTime? _selected;
  late CalendarFormat _calendarFormat;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.week;
    _selected = DateTime.now();
    _tickets = [];
    _fetchTickets(_selected!);
  }

  Future<void> _fetchTickets(DateTime date) async {
    String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final response = await http.get(
      Uri.parse(
          'https://100.74.7.89:3000/tickets-technicien/700a5357-8146-4eb7-a019-916da0f2b462/$formattedDate'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      List<Ticket> tickets =
          jsonData.map((ticketData) => Ticket.fromJson(ticketData)).toList();

      tickets
          .sort((a, b) => a.date.split('T')[1].compareTo(b.date.split('T')[1]));

      setState(() {
        _tickets = tickets;
      });
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: Center(
            child: Column(
              children: [
                _title(),
                TableCalendar(
                  firstDay: DateTime.utc(2022, 4, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selected, day);
                  },
                  onDaySelected: (selected, focused) {
                    if (!isSameDay(_selected, selected)) {
                      setState(() {
                        _selected = selected;
                        _focused = focused;
                      });
                      _fetchTickets(selected);
                    }
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  focusedDay: _focused,
                ),
                _buildTicketList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _tickets.length,
        itemBuilder: (context, index) {
          final ticket = _tickets[index];
          return Container(
            margin: const EdgeInsets.only(
              bottom: 10,
              right: 30,
              left: 30,
              top: 10,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(133, 114, 255, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/programmePlanning.svg',
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.nom,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10, width: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ticket.date.split('T')[1].split(':00.')[0],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ticket.date.split('T')[0],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _title() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Text(
        'Emploi du temps',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class Ticket {
  final String nom;
  final String date;

  Ticket({
    required this.nom,
    required this.date,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      nom: json['Probleme'] ?? '',
      date: json['DateRdv'] ?? '',
    );
  }
}
