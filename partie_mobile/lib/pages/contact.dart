import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late double screenWidth;
  final String phoneNumber = '+33646265513';
  final String emailAddress = 'trikiosama@gmail.com';
  final _controller = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  void _callHelpDesk() async {
    Uri url = Uri.parse('tel:$phoneNumber');
    await launchUrl(url);
  }

  void _emailHelpDesk() async {
    Uri url = Uri.parse('mailto:$emailAddress');
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: _contacter(),
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
        'Nous contacter',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Column _contacter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _title(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Text(
            'Vous avez rencontré un problème ?\nContactez le Call Desk',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8F9BB3),
              fontSize: screenWidth * 0.035,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _callHelpDesk,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 91, 165),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Appeler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _emailHelpDesk,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 91, 165),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Envoyer un email',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 7, 91, 165),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: PageView(
                  controller: _controller,
                  children: [
                    _qrCode("tel:$phoneNumber", "Numéro"),
                    _qrCode("mailto:$emailAddress", "Mail"),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color.fromARGB(255, 255, 255, 255),
                  dotColor: Colors.white60,
                  dotHeight: 20,
                  dotWidth: 20,
                  spacing: 10,
                  offset: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Column _qrCode(String data, String title) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      QrImageView(
        data: data,
        version: QrVersions.auto,
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Colors.white,
        ),
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Colors.white,
        ),
        size: 250,
        gapless: false,
      ),
    ],
  );
}
