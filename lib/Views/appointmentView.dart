import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalappointmentsystem/Services/AppointmentService.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';
import 'package:hospitalappointmentsystem/constants/string_constants.dart';
import 'package:hospitalappointmentsystem/drawerMenu.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppointmentView extends StatefulWidget {
  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Column(children: [
                Text(StringConstants.appointmentDescription1),
                Text(StringConstants.appointmentDescription2),
              ]),
            ),
          ),
          Expanded(
            flex: 7,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Branches').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final branches = snapshot.data!.docs;

                return ListView.builder(
                  physics:const BouncingScrollPhysics(),
                  itemCount: branches.length,
                  itemBuilder: (context, index) {
                    final branch = branches[index];
                    return Card(
                      child: ListTile(
                        title: Text(branch.id),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoctorsScreen(branch.reference),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorsScreen extends StatefulWidget {
  final DocumentReference branchRef;

  const DoctorsScreen(this.branchRef);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final dateNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.appointmentPageTitle),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.branchRef.collection('Doctors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child:  CircularProgressIndicator(),
            );
          }

          final doctors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              // Assuming each doctor document has a 'doctorName' field.
              return GestureDetector(
                child: ListTile(
                  title: Text(doctor['name']),
                  // Add more details about the doctor if needed.
                ),
                onTap: () {
                  showModalBottomSheet(
                    
                    shape:const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return AppointmentAdd(doctor: doctor, auth: auth, dateNow: dateNow);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class AppointmentAdd extends StatelessWidget {
  const AppointmentAdd({
    super.key,
    required this.doctor,
    required this.auth,
    required this.dateNow,
  });

  final QueryDocumentSnapshot<Object?> doctor;
  final FirebaseAuth auth;
  final DateTime dateNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(doctor['name']),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title:
                          const Text('Randevuyu Onaylıyormusunuz'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              AppointmentService()
                                  .addAppointment(
                                      userId: auth
                                          .currentUser!.uid,
                                      doctor: doctor['name'],
                                      date: dateNow);
showTopSnackBar(

    Overlay.of(context),
    CustomSnackBar.success(
      backgroundColor: Colors.green,
      message:
      
          "Randevunuz Oluşturuldu ${doctor['name']}  Tarih:$dateNow",
          
    ),
);
                           Constants().goPage(context, DrawerMenu());
                            },
                            child: const Text("Evet")),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Hayır"),
                        ),
                        
                      ],
                    ),
                    
                  );
                },
                child: const Text("Randevu Al")),
          ]),
    );
  }
}
