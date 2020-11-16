// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locatingInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocatingInformation _$LocatingInformationFromJson(Map<String, dynamic> json) {
  return LocatingInformation()
    ..location = json['location'] as List
    ..site = json['site'] as String
    ..description = json['description'] as String
    ..code = json['code'] as num;
}

Map<String, dynamic> _$LocatingInformationToJson(
        LocatingInformation instance) =>
    <String, dynamic>{
      'location': instance.location,
      'site': instance.site,
      'description': instance.description,
      'code': instance.code
    };
