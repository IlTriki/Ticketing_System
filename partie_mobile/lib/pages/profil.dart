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
    try {
      final response = await http
          .get(Uri.parse('https://100.74.7.89:3000/info-technicien/1'));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        setState(() {
          profilData = data.map((item) {
            return {
              'photo': 'https://100.74.7.89:3000/images/${item['Photo']}.jpg',
              'nom': item['nom'],
              'prenom': item['prenom'],
              'numero': item['numero'],
              'adresse': item['adresse'],
            };
          }).toList();
        });
      }
    } catch (error) {
      // Handle error
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title(),
                if (profilData.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 150,
                        backgroundImage: NetworkImage(profilData[0]['photo']),
                      ),
                      Text(
                        'Bienvenue ${profilData[0]['prenom']} ${profilData[0]['nom'].toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Numéro : ${profilData[0]['numero']}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Domicile : ${profilData[0]['adresse']}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
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
        'Profile',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
