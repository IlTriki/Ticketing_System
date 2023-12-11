import 'package:flutter/material.dart';
import 'package:partie_mobile/models/bottomnav_bar.dart';

class ProgrammePage extends StatelessWidget {
  const ProgrammePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programme de la semaine'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildDaySection('Lundi', [
            '8h00 - 10h00 : Réparation de l\'ordinateur',
            '10h30 - 12h00 : Installation du logiciel',
          ]),
          _buildDaySection('Mardi', [
            '9h00 - 11h00 : Maintenance du réseau',
            '14h00 - 16h00 : Configuration du serveur',
          ]),
          _buildDaySection('Mercredi', [
            '10h00 - 12h00 : Dépannage de l\'imprimante',
            '14h30 - 16h30 : Formation des utilisateurs',
          ]),
          _buildDaySection('Jeudi', [
            '8h30 - 10h30 : Installation du matériel',
            '11h00 - 13h00 : Réunion avec l\'équipe',
          ]),
          _buildDaySection('Vendredi', [
            '9h30 - 11h30 : Maintenance des équipements',
            '13h30 - 15h30 : Test de performance',
          ]),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar.buildBottomNavigationBar(1, context),
    );
  }

  Widget _buildDaySection(String day, List<String> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            day,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tasks[index]),
            );
          },
        ),
      ],
    );
  }
}
