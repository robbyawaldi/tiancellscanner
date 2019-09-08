import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

part 'item.g.dart';

class ItemModel {
  var _url = 'http://192.168.1.6/api/stocks/items/';

  Future<List<Item>> items() async {
    var response = await http.get(_url, headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Item> getById(String id) async {
    var response = await http.get('$_url$id', headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load item');
    }
  }
}

@JsonSerializable()
class Item {
    Item();

    num id;
    String name;
    num price;
    num stock;
    num currentpurchase;
    
    factory Item.fromJson(Map<String,dynamic> json) => _$ItemFromJson(json);
    Map<String, dynamic> toJson() => _$ItemToJson(this);
}
