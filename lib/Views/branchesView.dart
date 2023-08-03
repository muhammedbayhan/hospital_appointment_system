import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';

class BranchesView extends StatefulWidget {
  const BranchesView({super.key});

  @override
  State<BranchesView> createState() => _BranchesViewState();
}

class _BranchesViewState extends State<BranchesView> {
  final doctorRef =
      FirebaseFirestore.instance.collectionGroup("Branches").snapshots();
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream: doctorRef,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:3),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];

                return GestureDetector(
                  child: Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text(doc["title"],style: TextStyle(color:Theme.of(context).cardColor),))),
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return BranchesBottomSheet(doc: doc);
                      },
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Veriler çekilirken bir hata oluştu.');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class BranchesBottomSheet extends StatelessWidget {
  const BranchesBottomSheet({
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
            Text(doc["title"]),
            Text(doc["description"]),
          ],
        ),
      ),
    );
  }
}
