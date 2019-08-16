import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  Service();

  Service.input({this.brand, this.type, this.desc, this.cost, this.price});

  String brand;
  String type;
  String desc;
  num cost;
  num price;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
