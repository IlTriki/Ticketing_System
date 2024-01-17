import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:partie_mobile/models/chrono_programme.dart';
import 'package:geocoding/geocoding.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  late double screenWidth;
  List<Map<String, dynamic>> programmes = [];
  // les horaires de depart, d'arrivee et la duree d'entretien du ticket
  DateTime? heureDepart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    screenWidth = MediaQuery.of(context).size.width;
  }

  Future<void> fetchData() async {
    final date = DateTime.now();
    String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final response = await http.get(Uri.parse(
        'https://100.74.7.89:3000/tickets-technicien-progJour/700a5357-8146-4eb7-a019-916da0f2b462/$formattedDate'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      setState(() {
        programmes = data.map((item) {
          return {
            'id': item["Id"],
            'priorite': "assets/icons/priorite${item['Priority']}.svg",
            'horaire':
                "${item['HeureDebutCreneau'].toString().substring(0, 5)}-${item['HeureFinCreneau'].toString().substring(0, 5)}",
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
              ? const Center(child: CircularProgressIndicator())
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
                                launchUrlString(
                                    'http://support.ricoh.com/bb_v1oi/pub_e/oi/0001031/0001031308/VB23578xx_01/B2357832.pdf');
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
                              onTap: () async {
                                heureDepart = DateTime.now();
                                List<Location> locations =
                                    await getCoordinatesFromAddress(
                                        programmes[index]['adresse']);
                                if (locations.isNotEmpty) {
                                  launchWazeRoute(locations[0].latitude,
                                      locations[0].longitude);
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/icons/boutonGo.svg',
                                width: screenWidth * 0.10,
                                height: screenWidth * 0.10,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 1.67 * 25,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => TicketDetailsPage(
                                    ticketDetails: programmes[index],
                                    heureDepart: heureDepart,
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/boutonStart.svg',
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

Future<List<Location>> getCoordinatesFromAddress(String adresse) async {
  try {
    List<Location> locations = await locationFromAddress(adresse);
    return locations;
  } catch (error) {
    print(error);
    return [];
  }
}

Future<void> launchWazeRoute(double lat, double lng) async {
  var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
  var fallbackUrl =
      'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';

  try {
    bool launched = false;
    if (!kIsWeb) {
      launched = await launchUrl(Uri.parse(url));
    }
    if (!launched) {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  } catch (e) {
    await launchUrl(Uri.parse(fallbackUrl));
  }
}
