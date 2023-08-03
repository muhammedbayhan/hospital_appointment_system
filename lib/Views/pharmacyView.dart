import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hospitalappointmentsystem/Models/pharmacyModel.dart';
import 'package:hospitalappointmentsystem/Services/PharmacyService.dart';
import 'package:hospitalappointmentsystem/Widgets/Wtextfield.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';

class PharmacyView extends StatefulWidget {
  const PharmacyView({super.key});

  @override
  State<PharmacyView> createState() => _PharmacyViewState();
}

class _PharmacyViewState extends State<PharmacyView> {
  List<PharmacyModel>? _pharmacy;
  final PharmacyService _pharmacyService = PharmacyService();
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  Future<void> fetchUser() async {
    _pharmacy = await _pharmacyService.fetchPharmacy();

    setState(() {});
  }

  final TextEditingController _sehir = TextEditingController();
  final TextEditingController _ilce = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nöbetçi Eczaneler"),
        leading: IconButton(
            onPressed: () {
              SimpleHiddenDrawerController.of(context).toggle();
            },
            icon: const Icon(Icons.menu)),
      ),
      body: Padding(
        padding: Constants.pagepadding,
        child: Column(
          children: [
            Widget_Textfield(hintText: "Şehir", controller: _sehir),
            const SizedBox(
              height: 10,
            ),
            Widget_Textfield(hintText: "İlçe", controller: _ilce),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _pharmacy?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        contentPadding: Constants.pagepadding,
                        title: Text(_pharmacy?[index].eczaneAdi ?? ""),
                        leading: Icon(
                          Icons.local_pharmacy,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 15,
                                ),
                                Flexible(
                                    child:
                                        Text(_pharmacy?[index].adresi ?? "")),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                Text(_pharmacy?[index].telefon ?? ""),
                              ],
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
