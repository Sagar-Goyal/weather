import 'package:weather/constants/data.dart';
import 'package:weather/model/address_model.dart';
import 'package:weather/service/network_service.dart';

class AddressController {
  static Future getAddress(double lat, double lon) async {
    String url = "${addressBaseUrl}lat=$lat&lon=$lon&apiKey=$addressApiKey";
    NetworkService networkService = NetworkService(url: url);
    try {
      var data = await networkService.getData();
      AddressModel addressModel = AddressModel.fromJson(data);
      return addressModel;
    } catch (e) {
      rethrow;
    }
  }
}
