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
  late double screenHeight;
  List<ProgrammeModel> programmes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    programmes = ProgrammeModel.getProgrammes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _programmes(),
        ],
      ),
    );
  }

  Column _programmes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            top: screenWidth * 0.05,
          ),
          child: Text(
            'Programme du jour :',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.8,
          child: ListView.separated(
            itemCount: programmes.length,
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.03,
              top: screenHeight * 0.03,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ),
                          SvgPicture.asset('assets/icons/options.svg',
                              width: screenWidth * 0.010,
                              height: screenWidth * 0.010),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SvgPicture.asset(
                          'assets/icons/boutonGo.svg',
                          width: screenWidth * 0.35,
                          height: screenWidth * 0.35,
                        ),
                      ],
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
