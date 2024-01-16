import 'package:flutter/material.dart';

void navigateToPage(BuildContext context, Widget page) {
  Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void navigateToPageWithBack(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
