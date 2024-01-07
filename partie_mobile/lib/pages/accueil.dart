import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  late double screenWidth;
  List<Map<String, dynamic>> programmes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    screenWidth = MediaQuery.of(context).size.width;
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://100.74.7.89:3000/tickets-technicien/1'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      setState(() {
        programmes = data.map((item) {
          return {
            'priorite': "assets/icons/priorite${item['Priority']}.svg",
            'horaire': DateFormat('HH:mm')
                .format(DateTime.parse(item['DateCreation'])),
            'nom': item['Probleme'],
            'adresse': item['Adresse'],
            'lieu': item['Lieu'],
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
        child: _programmes(),
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
        'Programme du jour',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Column _programmes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.792,
          child: programmes.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: programmes.length,
                  padding: const EdgeInsets.only(
                    bottom: 30,
                    right: 30,
                    left: 30,
                    top: 20,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 25,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height:
                          120, // Adjusted height to accommodate both address and location
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  programmes[index]['priorite'],
                                  width: screenWidth * 0.035,
                                  height: screenWidth * 0.035,
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  programmes[index]['horaire'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF8F9BB3),
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                launchUrlString('https://www.google.com/maps');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/options.svg',
                                width: screenWidth * 0.010,
                                height: screenWidth * 0.010,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  programmes[index]['nom'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                Text(
                                  '${programmes[index]['lieu']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF8F9BB3),
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                                Text(
                                  programmes[index]['adresse'].length > 30
                                      ? '${programmes[index]['adresse'].substring(0, 30)}...'
                                      : programmes[index]['adresse'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF8F9BB3),
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                launchUrlString('https://www.google.com/maps');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/boutonGo.svg',
                                width: screenWidth * 0.10,
                                height: screenWidth * 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
