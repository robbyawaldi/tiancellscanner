import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

import 'cart.dart';

part 'service.g.dart';

class ServiceModel {
  var _url = 'http://192.168.1.6/api/services/services/';

  Future<int> post(Service service) async {
    var response = await http.post(_url,
        headers: {'Authorization': basicAuth}, body: service.toJson());
    return response.statusCode;
  }

  Future<List<Service>> postAll(List<Service> _services) async {
    List<int> indexs = [];
    for (Service service in _services) {
      indexs.add(await post(service));
    }
    
    for (var i = 0; i < indexs.length; i++) {
      if (indexs[i] == 201) {
        _services.removeAt(i);
      }
    }
    return _services;
  }
}

@JsonSerializable()
class Service implements CartList {
  Service();

  String brand;
  String type;
  String desc;
  num cost;
  num price;

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
