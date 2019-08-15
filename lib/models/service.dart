import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
    Service();

    String brand;
    String type;
    String desc;
    num cost;
    num price;
    
    factory Service.fromJson(Map<String,dynamic> json) => _$ServiceFromJson(json);
    Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
