import 'package:dio/dio.dart';
import 'package:hospitalappointmentsystem/Models/pharmacyModel.dart';

class PharmacyService {
  Future<List<PharmacyModel>?> fetchPharmacy() async {
       final response = await Dio().get(
        "API KEY",
    );
 
    if (response.statusCode == 200) {

      final _datas = response.data["data"];
      print("++++++++++++++++++");
      if (_datas is List) {
        print("-------------------");
        print(_datas);
        return _datas.map((e) => PharmacyModel.fromJson(e)).toList();
      }
    }

    return null;
  }
}
