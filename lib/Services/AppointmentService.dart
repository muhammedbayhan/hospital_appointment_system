import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentService {
  
final userCollection = FirebaseFirestore.instance.collection("Appointments");
  final firebaseAuth = FirebaseAuth.instance;
final now = DateTime.now();
  Future<void> addAppointment(
      {required String userId,
      required String doctor,
      required DateTime date}) async {
  
    await userCollection
        .doc()
        .set({"userId": userId, "doctor": doctor, "date": date});
  }






}