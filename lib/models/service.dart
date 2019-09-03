import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

part 'service.g.dart';

class ServiceModel {
  var _url = 'http://192.168.1.6/api/services/services/';

  Future<int> post(Service service) async {
    var response = await http.post(_url,
        headers: {'Authorization': basicAuth}, body: service.toJson());
    return response.statusCode;
  }

  List<Service> postAll(List<Service> _services) {
    _services.forEach((service) {
      post(service).then((response) {
        if (response == 201) {
          _services.remove(service);
        }
      });
    });
    return _services;
  }
}

@JsonSerializable()
class Service {
  Service();

  String brand;
  String type;
  String desc;
  num cost;
  num price;

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
