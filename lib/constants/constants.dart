import 'package:flutter/material.dart';

class Constants {
static EdgeInsets pagepadding=EdgeInsets.all(12);
static BorderRadius borderRadius=BorderRadius.circular(12);

void goPage(BuildContext context,Widget page){
       Navigator.pushReplacement(
  context,
  PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
  ),
);
}
}