// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class Widget_CardButton extends StatelessWidget {
  Widget_CardButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.function});
  String text;
  IconData icon;
  Color color;
  Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                 FaIcon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
              ),
           
            ],
          )), //
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      onTap: (){function();},
    );
  }
}