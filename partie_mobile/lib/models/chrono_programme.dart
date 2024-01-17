import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TicketDetailsPage extends StatefulWidget {
  final Map<String, dynamic> ticketDetails;
  DateTime? heureDepart;

  TicketDetailsPage({Key? key, required this.ticketDetails, this.heureDepart})
      : super(key: key);

  @override
  _TicketDetailsPageState createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  DateTime? heureDebut;
  DateTime? heureFin;
  Duration? duree;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Entretien actuel:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Horaire: ${widget.ticketDetails['horaire']}',
          ),
          const SizedBox(height: 10),
          Text(
            'Nom: ${widget.ticketDetails['nom']}',
          ),
          const SizedBox(height: 10),
          Text(
            'Lieu: ${widget.ticketDetails['lieu']}',
          ),
          const SizedBox(height: 10),
          Text(
            'Adresse: ${widget.ticketDetails['adresse']}',
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Chronomètre:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, milliSecond: false);
                  return Text(
                    displayTime,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  _stopWatchTimer.onStartTimer();
                  setState(() {
                    heureDebut ??= DateTime.now();
                  });
                },
                child: const Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Color(0xFF1A73E8),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _stopWatchTimer.onStopTimer();
                  setState(() {
                    if (heureDebut != null) {
                      if (heureFin == null) {
                        widget.heureDepart ??= heureDebut;
                        heureFin = DateTime.now();
                        duree = heureFin?.difference(heureDebut!);

                        updateTicketDetails(
                          widget.ticketDetails['id'].toString(),
                          heureDebut,
                          heureFin,
                          duree,
                        );
                      }
                    }
                  });
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.stop,
                  size: 50,
                  color: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _stopWatchTimer.onResetTimer();
                  setState(() {
                    heureDebut = null;
                    heureFin = null;
                    duree = null;
                    widget.heureDepart = null;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updateTicketDetails(String ticketId, DateTime? dateDepart,
      DateTime? dateArrivee, Duration? duree) async {
    final apiUrl = 'https://100.74.7.89:3000/update-rdv/$ticketId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'DateDepart': dateDepart?.toIso8601String(),
          'DateArrivee': dateArrivee?.toIso8601String(),
          'Duree': duree.toString(),
        }),
      );

      if (response.statusCode == 200) {
        print('Ticket updated successfully');
      } else {
        print('Failed to update ticket. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating ticket: $e');
    }
  }
}
