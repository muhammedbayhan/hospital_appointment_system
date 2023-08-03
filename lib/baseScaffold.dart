import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'controllers/BottomNavBarController.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  final BottomNavBarController _controller = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(_controller.pageNames[_controller.currentIndex.value]),
            leading: IconButton(
                onPressed: () {
                  SimpleHiddenDrawerController.of(context).toggle();
                },
                icon: Icon(Icons.menu)),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _controller.currentIndex.value,
            items: const <Widget>[
              Icon(Icons.add, size: 30),
              Icon(Icons.grid_view_outlined, size: 30),
              Icon(Icons.home, size: 30),
              Icon(Icons.groups_outlined, size: 30),
              Icon(Icons.perm_identity, size: 30),
            ],
            color: Theme.of(context).colorScheme.primary,
            buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 500),
            onTap: _controller.onTap,
            letIndexChange: (index) => true,
          ),
          body: _controller.views[_controller.currentIndex.value],
        ));
  }
}
