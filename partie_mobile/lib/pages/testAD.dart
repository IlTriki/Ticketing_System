import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:aad_oauth/model/token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAD OAuth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AAD OAuth Home'),
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final Config config = Config(
    tenant: '606b4859-aaa5-49d1-b841-d026b1053dc8',
    clientId: 'f587a308-979f-450f-bd3a-9307e7cbeccb',
    clientSecret: 'Nnq8Q~-AVcTe1AwmzledAWvEqN1s2xAhbx~X_bC_',
    scope: 'openid profile offline_access User.Read',
    redirectUri:
        'https://100.74.7.89/technicien/', // Set your custom redirect URI
    navigatorKey: navigatorKey,
    loader: SizedBox(),
    appBar: AppBar(
      title: Text('AAD OAuth Demo'),
    ),
  );

  final AadOAuth oauth = AadOAuth(config);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListTile(
            leading: Icon(Icons.launch),
            title: Text('Login${kIsWeb ? ' (web popup)' : ''}'),
            onTap: () {
              login(false);
            },
          ),
          if (kIsWeb)
            ListTile(
              leading: Icon(Icons.launch),
              title: Text('Login (web redirect)'),
              onTap: () {
                login(true);
              },
            ),
          ListTile(
            leading: Icon(Icons.data_array),
            title: Text('HasCachedAccountInformation'),
            onTap: () => hasCachedAccountInformation(),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login(bool redirect) async {
    config.webUseRedirect = redirect;
    final result = await oauth.login();
    result.fold(
      (l) => showError(l.toString()),
      (r) {
        showMessage('Logged in successfully, your access token: $r');
        Future.delayed(Duration(seconds: 2), () async {
          var accessToken = await oauth.getAccessToken();
          if (accessToken != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(accessToken)));

            // Call getUserObjectId after obtaining the access token
            getUserObjectId(accessToken);

            // Decode and print the access token claims
            decodeAccessToken(accessToken);
          }
        });
      },
    );
  }

  void hasCachedAccountInformation() async {
    var hasCachedAccountInformation = await oauth.hasCachedAccountInformation;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('HasCachedAccountInformation: $hasCachedAccountInformation'),
      ),
    );
  }

  void logout() async {
    await oauth.logout();
    showMessage('Logged out');
  }

  void getUserObjectId(String accessToken) async {
    final graphApiEndpoint = 'https://graph.microsoft.com/v1.0/me';

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
      showMessage('User Object ID: $objectId');
      print('User Object ID: $objectId');
    } else {
      showError(
        'Failed to get user information. Status code: ${response.statusCode}',
      );

      // Print the error response body
      print('Error Response Body: ${response.body}');
    }
  }

  void decodeAccessToken(String accessToken) {
    final parts = accessToken.split('.');
    if (parts.length != 3) {
      print('Invalid token format');
      return;
    }

    final payload = parts[1];
    // Ensure proper padding for Base64 decoding
    final int padLength = (4 - payload.length % 4) % 4;
    final String paddedPayload = payload + '=' * padLength;
    final String decodedPayload =
        String.fromCharCodes(base64Url.decode(paddedPayload));
    print('Decoded Payload: $decodedPayload');

    final Map<String, dynamic> payloadMap = json.decode(decodedPayload);
    final String audience = payloadMap['aud'];

    // Check if the audience matches your expected client ID
    if (audience == 'f587a308-979f-450f-bd3a-9307e7cbeccb') {
      print('Valid audience: $audience');
      // Continue processing the token...
    } else {
      print('Invalid audience: $audience');
      // Handle invalid audience...
    }
  }
}
