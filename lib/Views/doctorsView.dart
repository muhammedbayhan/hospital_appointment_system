import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';

class DoctorsView extends StatefulWidget {
  const DoctorsView({super.key});

  @override
  State<DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {


  final doctorRef =
      FirebaseFirestore.instance.collectionGroup("Doctors").snapshots();
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Padding(
        padding: Constants.pagepadding,
        child: StreamBuilder<QuerySnapshot>(
          stream: doctorRef,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];

                  return DoctorCard(doc: doc);
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Veriler çekilirken bir hata oluştu.');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;
 
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person),backgroundColor: Theme.of(context).colorScheme.primary,),
        title: Text(doc["name"]),
        subtitle: Text(doc["specialist"]),
        trailing: IconButton(
            onPressed: () {
              
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                context: context,
                builder: (context) {
                  return DoctorBottomSheet(doc: doc);
                },
              );
            },
            icon:const Icon(Icons.chevron_right)),
      ),
    );
  }
}

class DoctorBottomSheet extends StatelessWidget {
  const DoctorBottomSheet({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.pagepadding,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(doc["name"]),
         
            Text(doc["biography"]),
            
          ],
        ),
      ),
    );
  }
}
