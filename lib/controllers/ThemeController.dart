import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
var color=Colors.teal.shade100.obs;
var x=true.obs;
List<Color> colorList=[Colors.red,Colors.green,Colors.deepPurpleAccent,Colors.teal.shade100,Colors.black,Colors.orange,Colors.deepPurple,Colors.green];

void changeColor(){
  Random random=Random();
 var r=random.nextInt(colorList.length-1);
  x.value=!x.value;
  if (x.value==true) {
      color.value=colorList[r];
  }
  else{
    color.value=Colors.teal.shade100;
  }

}

}
