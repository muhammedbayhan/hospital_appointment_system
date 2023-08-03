import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalappointmentsystem/Services/AuthService.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';
import 'package:hospitalappointmentsystem/constants/string_constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../controllers/ThemeController.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ThemeController _controller = Get.put(ThemeController());
  final query = FirebaseFirestore.instance
      .collection("Appointments")
      .where("userId", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constants.pagepadding,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(StringConstants.profilePageTitle,
                style: Theme.of(context).textTheme.headlineSmall),
            Expanded(
              flex: 8,
              child: StreamBuilder<QuerySnapshot>(
                stream: query,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];

                        return Card(
                          child: ListTile(
                            title: Text(doc["doctor"]),
                            subtitle: Text(
                              " Randevu Tarihi : ${doc["date"]}",
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                        title: Text(
                                            'Randevuyu Silmek İstiyormusunuz?-> ${doc["doctor"]}'),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "Appointments")
                                                      .doc(doc.id)
                                                      .delete();

                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    CustomSnackBar.error(
                                                      message:
                                                          "Randevu Silindi : ${doc["doctor"]}",
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Evet")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Hayır"))
                                          ],
                                        )),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                )),
                          ),
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
            ),
            const SizedBox(
              height: 20,
            ),
            Text("${AuthService().firebaseAuth.currentUser?.email}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _controller.changeColor();
                    },
                    child: Text("Tema Değiştir")),
                ElevatedButton(
                    onPressed: () {
                      AuthService().signOut(context);
                    },
                    child: Text("Çıkış Yap"))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
