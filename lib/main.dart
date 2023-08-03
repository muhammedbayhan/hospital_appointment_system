import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospitalappointmentsystem/Auth/loginView.dart';

import 'package:hospitalappointmentsystem/firebase_options.dart';

import 'controllers/ThemeController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController _controller = Get.put(ThemeController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
           fontFamily: GoogleFonts.openSans().fontFamily,
            iconTheme: const IconThemeData(color: Colors.white),

            appBarTheme: const AppBarTheme(
              centerTitle: false,
              foregroundColor: Colors.black,
              toolbarHeight: kToolbarHeight + 50,
       
              backgroundColor: Colors.transparent,
              elevation:0,
            ), 
            colorScheme:
                ColorScheme.fromSeed(seedColor: _controller.color.value),
            useMaterial3: false,
          ),
          home: LoginView(),
        ));
  }
}
