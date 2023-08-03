import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Widget_Textfield extends StatelessWidget {
  const Widget_Textfield({
    super.key,required this.hintText,required this.controller, this.obscureText=false,this.textInputType=TextInputType.text,
  });
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: Constants.borderRadius),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextField(
          keyboardType: textInputType,
          obscureText: obscureText,
          controller: controller,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: hintText),
        ),
      ),
    );
  }
}
