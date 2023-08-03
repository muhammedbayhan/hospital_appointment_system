import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hospitalappointmentsystem/Auth/loginView.dart';
import 'package:hospitalappointmentsystem/Views/pharmacyView.dart';
import 'package:hospitalappointmentsystem/baseScaffold.dart';

import 'Services/AuthService.dart';
import 'controllers/BottomNavBarController.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final BottomNavBarController _controller = Get.put(BottomNavBarController());

  List<ScreenHiddenDrawer> _pages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Anasayfa",
              baseStyle: const TextStyle(color: Colors.white),
              selectedStyle: const TextStyle(),
              colorLineSelected: Colors.white,
              onTap: () {
                _controller.currentIndex.value = 2;
              }),
          const BaseScaffold()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Profil",
              baseStyle: const TextStyle(color: Colors.white),
              selectedStyle:const  TextStyle(),
              colorLineSelected: Colors.white,
              onTap: () {
                _controller.currentIndex.value = 4;
              }),
          const BaseScaffold()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Nöbetçi Eczane",
            baseStyle:const  TextStyle(color: Colors.white),
            selectedStyle:const  TextStyle(),
            colorLineSelected: Colors.white

          ),
         const  PharmacyView()),

                ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Çıkış Yap",
              baseStyle: const TextStyle(color: Colors.white),
              selectedStyle: const TextStyle(),
              colorLineSelected: Colors.white,
              onTap: () {
                AuthService().signOut(context);
              }),const LoginView(),
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Theme.of(context).colorScheme.primary,
      screens: _pages,
      initPositionSelected: 0,
      disableAppBarDefault: true,
      
      
    );
  }
}
