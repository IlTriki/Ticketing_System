import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      home: TicketListScreen(),
    );
  }
}

class TicketListScreen extends StatefulWidget {
  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  List<dynamic> tickets = [];

  @override
  void initState() {
    super.initState();
    // Fetch tickets when the screen is created
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    final response =
        await http.get(Uri.parse('http://100.74.7.89:3000/tickets'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      setState(() {
        tickets = json.decode(response.body);
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load tickets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket List'),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (BuildContext context, int index) {
          final ticket = tickets[index];
          return ListTile(
            title: Text('Ticket ID: ${ticket['Id']}'),
            subtitle: Text('Problem: ${ticket['Probleme']}'),
            // Add more details as needed
          );
        },
      ),
    );
  }
}
