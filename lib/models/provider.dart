import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';
import "nominal.dart";

part 'provider.g.dart';

class ProviderModel {
  var _url = 'http://192.168.1.6/api/pulsa/providers/';

  Future<List<Provider>> providers() async {
    var response = await http.get(_url, headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      List<dynamic> providers = json.decode(response.body);
      return providers.map((provider) => Provider.fromJson(provider)).toList();
    } else {
      throw Exception('Failed to load providers');
    }
  }

  Future<Provider> getById(String id) async {
    var response = await http.get('$_url$id', headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      return Provider.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load provider');
    }
  }
}

@JsonSerializable()
class Provider {
    Provider();

    String name;
    List<Nominal> nominals;
    
    factory Provider.fromJson(Map<String,dynamic> json) => _$ProviderFromJson(json);
    Map<String, dynamic> toJson() => _$ProviderToJson(this);
}
