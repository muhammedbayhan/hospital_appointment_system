import 'package:dio/dio.dart';
import 'package:hospitalappointmentsystem/Models/pharmacyModel.dart';

class PharmacyService {
  Future<List<PharmacyModel>?> fetchPharmacy() async {
       final response = await Dio().get(
        "https://www.nosyapi.com/apiv2/pharmacyLink?city=istanbul&county=fatih&apikey=bCPitAQIzqO4f1Igt9swGt5or0BqQaRM8m3YywfLfiMw4Eq5aSITh0gV0K21",
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
