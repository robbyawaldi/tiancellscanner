import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

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
