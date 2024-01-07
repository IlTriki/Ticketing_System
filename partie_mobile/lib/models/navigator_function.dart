import 'package:flutter/material.dart';

void navigateToPage(BuildContext context, Widget page) {
  Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void navigateToPageWithReplacement(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
