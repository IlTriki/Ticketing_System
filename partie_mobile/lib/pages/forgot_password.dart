import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordPage extends StatelessWidget {
  final String phoneNumber = '+33646265513';
  final String emailAddress = 'trikiosama@gmail.com';

  const ForgotPasswordPage({super.key});

  void _callHelpDesk() async {
    Uri url = Uri.parse('tel:$phoneNumber');
    await launchUrl(url);
  }

  void _emailHelpDesk() async {
    Uri url = Uri.parse('mailto:$emailAddress?subject=Mot de passe oublié');
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mot de passe oublié'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Contactez le help desk pour réinitialiser votre mot de passe',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _callHelpDesk,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF003869),
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
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _emailHelpDesk,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF003869),
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
          ],
        ),
      ),
    );
  }
}
