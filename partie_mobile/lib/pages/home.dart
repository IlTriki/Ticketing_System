import 'package:flutter/material.dart';
import 'package:partie_mobile/models/programme_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double screenWidth;
  List<ProgrammeModel> programmes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    programmes = ProgrammeModel.getProgrammes();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _appBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _programmes(),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.78,
          child: ListView.separated(
              itemCount: programmes.length,
              padding: const EdgeInsets.only(
                bottom: 30,
                right: 30,
                left: 30,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 25,
                  ),
              itemBuilder: (context, index) {
                return Container(
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
                    child: Stack(children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            programmes[index].priorite,
                            width: screenWidth * 0.035,
                            height: screenWidth * 0.035,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            programmes[index].horaire,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8F9BB3),
                              fontSize: screenWidth * 0.035,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SvgPicture.asset('assets/icons/options.svg',
                            width: screenWidth * 0.010,
                            height: screenWidth * 0.010),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                programmes[index].nom,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                              Text(
                                programmes[index].lieu,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF8F9BB3),
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset('assets/icons/boutonGo.svg',
                                  width: screenWidth * 0.35)
                            ],
                          )
                        ],
                      )
                    ]));
              }),
        ),
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(backgroundColor: Colors.white, items: const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Color(0xFF1A73E8),
        ),
        label: 'Accueil',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.calendar_today,
          color: Colors.black,
        ),
        label: 'Programme',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        label: 'Profil',
      ),
    ]);
  }
}
