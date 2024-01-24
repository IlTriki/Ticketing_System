import 'package:flutter/material.dart';
import 'package:partie_mobile/models/navigator_function.dart';
import 'package:partie_mobile/models/text_field.dart';
import 'package:partie_mobile/pages/contact.dart';
import 'package:partie_mobile/pages/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // textfield controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var errorMessage = '';

  static const config = (
    tenant: 'your_tenant_id',
    clientId: 'your_client_id',
    clientSecret: 'your_client_secret',
  );

  final AuthService authService = AuthService(
    tenant: config.tenant,
    clientId: config.clientId,
    clientSecret: config.clientSecret,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              // Logo
              Container(
                margin: const EdgeInsets.all(20),
                child: Image(
                  image: const AssetImage('assets/images/logoSAEvFinale.png'),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),

              // Message de bienvenue
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Bienvenue',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    margin: const EdgeInsets.only(top: 60),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Connectez-vous pour continuer',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0XFF003869),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailTextController,
                icon: const Icon(
                  Icons.email,
                  color: Color(0XFF003869),
                ),
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                hintText: "Mot de passe",
                obscureText: true,
                controller: passwordTextController,
                icon: const Icon(
                  Icons.lock,
                  color: Color(0XFF003869),
                ),
              ),

              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 5),

              // connexion button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      errorMessage = '';
                    });

                    if (emailTextController.text.isEmpty ||
                        passwordTextController.text.isEmpty) {
                      setState(() {
                        errorMessage = 'Veuillez remplir tous les champs';
                      });
                    } else {
                      FocusScope.of(context).unfocus();
                      authService.performROPC(
                        emailTextController.text,
                        passwordTextController.text,
                        context,
                        (String error) {
                          setState(() {
                            errorMessage = error;
                          });
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF003869),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // forgot password
              TextButton(
                onPressed: () {
                  navigateToPageWithBack(context, const ContactPage());
                },
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    color: Color(0XFF003869),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final String tenant;
  final String clientId;
  final String clientSecret;

  AuthService({
    required this.tenant,
    required this.clientId,
    required this.clientSecret,
  });

  Future<void> performROPC(String username, String password,
      BuildContext context, Function(String) errorCallback) async {
    final Map<String, dynamic> body = {
      'grant_type': 'password',
      'client_id': clientId,
      'client_secret': clientSecret,
      'scope': 'openid profile offline_access User.Read',
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(
          'https://login.microsoftonline.com/${tenant}/oauth2/v2.0/token'),
      body: body,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> tokenData = json.decode(response.body);
      final String accessToken = tokenData['access_token'];
      getUserObjectId(accessToken, context);
    } else {
      errorCallback("Mot de passe ou email incorrect");
    }
  }

  void getUserObjectId(String accessToken, BuildContext context) async {
    const graphApiEndpoint = 'https://graph.microsoft.com/v1.0/me';

    final response = await http.get(
      Uri.parse(graphApiEndpoint),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      final String objectId = userData['id'];
      navigateToPage(context, HomePage(objectId: objectId));
    } else {}
  }
}
