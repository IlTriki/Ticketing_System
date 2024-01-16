import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TicketDetailsPage extends StatefulWidget {
  final Map<String, dynamic> ticketDetails;

  const TicketDetailsPage({Key? key, required this.ticketDetails})
      : super(key: key);

  @override
  _TicketDetailsPageState createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  var heureDebut;
  var heureFin;
  var duree;

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
                        heureFin = DateTime.now();
                        duree = heureFin.difference(heureDebut);
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
}
