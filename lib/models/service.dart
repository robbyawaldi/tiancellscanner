import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

import 'cart.dart';

part 'service.g.dart';

class ServiceModel {
  var _url = 'http://192.168.1.6/api/services/services/';

  Future<int> post(Service service) async => await http
          .post(_url,
              headers: {'Authorization': basicAuth}, body: service.toJson())
          .then((response) {
        return response.statusCode;
      }).catchError((onError) {
        return 408;
      });

  Future<List<Service>> postAll(List<Service> _services) async {
    List<Service> failedPost = [];
    for (Service service in _services) {
      var response = await post(service);
      if (response != 201) {
        failedPost.add(service);
      }
    }
    return failedPost;
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

  factory Service.fromJson(Map<String,dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
