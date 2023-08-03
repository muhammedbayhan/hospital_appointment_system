import 'package:get/get.dart';
import 'package:hospitalappointmentsystem/Views/appointmentView.dart';
import 'package:hospitalappointmentsystem/Views/doctorsView.dart';
import 'package:hospitalappointmentsystem/Views/homeView.dart';
import 'package:hospitalappointmentsystem/Views/profileView.dart';
import 'package:hospitalappointmentsystem/Views/branchesView.dart';

class BottomNavBarController extends GetxController {
  List views = [
    AppointmentView(),
    const BranchesView(),
    const HomeView(),
    const DoctorsView(),
    const ProfileView(),
  ];
  List pageNames = [
    "Poliklinik Seçiniz",
    "Branşlar",
    "Anasayfa",
    "Doktorlar",
    "Profil"
  ];
  var currentIndex = 2.obs;

  void onTap(var index) {
    currentIndex.value = index;
    print(currentIndex.value);
  }


}
