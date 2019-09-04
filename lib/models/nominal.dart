import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

part 'nominal.g.dart';

class NominalModel {
  var _url = 'http://192.168.1.6/api/pulsa/nominals/';

  Future<Nominal> getById(String id) async {
    var response = await http.get('$_url$id', headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      return Nominal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load nominal');
    }
  }
}

@JsonSerializable()
class Nominal {
    Nominal();

    num id;
    num provider;
    String name;
    num cost;
    num price;
    
    factory Nominal.fromJson(Map<String,dynamic> json) => _$NominalFromJson(json);
}
