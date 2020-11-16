import 'package:json_annotation/json_annotation.dart';

part 'locatingInformation.g.dart';

@JsonSerializable()
class LocatingInformation {
    LocatingInformation();

    List location;
    String site;
    String description;
    num code;
    
    factory LocatingInformation.fromJson(Map<String,dynamic> json) => _$LocatingInformationFromJson(json);
    Map<String, dynamic> toJson() => _$LocatingInformationToJson(this);
}
