import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late double screenWidth;
  List<Map<String, dynamic>> profilData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    screenWidth = MediaQuery.of(context).size.width;
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://100.74.7.89:3000/technicien/1'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      setState(() {
        profilData = data.map((item) {
          return {
            'photo': item['Photo'],
            'nom': item['nom'],
            'prenom': item['prenom'],
            'numero': item['numero'],
            'adresse': item['adresse'],
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profil'),
            const SizedBox(height: 20),
            const Icon(
              Icons.person,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              profilData[0]['nom'] + ' ' + profilData[0]['prenom'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profilData[0]['numero'] + '\n' + profilData[0]['adresse'],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
