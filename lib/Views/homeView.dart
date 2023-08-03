import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hospitalappointmentsystem/Widgets/WcardButton.dart';
import 'package:hospitalappointmentsystem/constants/string_constants.dart';
import '../controllers/BottomNavBarController.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
    final BottomNavBarController _controller = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            ExpansionTileCard(
      leading: CircleAvatar(
            child: Text("0"),
            backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      title:  Text(StringConstants.activeAppointment),
      children: [
            Container(
  
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person),backgroundColor: Theme.of(context).colorScheme.primary,),
            title: const Text("Doctor Name"),
            subtitle:const  Text("specialist"),
            trailing: IconButton(
                onPressed: () {
               
                },
                icon:const  Icon(Icons.chevron_right)),
      ),
            )
      ],
    ),
SizedBox(height:MediaQuery.of(context).size.height*0.04 ,),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Widget_CardButton(text: StringConstants.cardButton1, icon: FontAwesomeIcons.calendarCheck, color: Theme.of(context).colorScheme.primary,function: (){_controller.currentIndex.value=0;}),
  Widget_CardButton(text:StringConstants.cardButton2, icon: FontAwesomeIcons.userDoctor, color: Theme.of(context).colorScheme.primary,function: (){_controller.currentIndex.value=3;}),
],),

Row(
   mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Widget_CardButton(text: StringConstants.cardButton3, icon: FontAwesomeIcons.codeBranch, color: Theme.of(context).colorScheme.primary,function: (){_controller.currentIndex.value=1;}),
  Widget_CardButton(text: StringConstants.cardButton4, icon: FontAwesomeIcons.kitMedical, color: Theme.of(context).colorScheme.primary,function: (){}),
],),


          ],
        ));
  }
}
