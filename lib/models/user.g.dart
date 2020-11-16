// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..identity = json['identity'] as String
    ..userID = json['userID'] as String
    ..headPortrait = json['headPortrait'] as String
    ..token = json['token'] as String
    ..code = json['code'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'identity': instance.identity,
      'userID': instance.userID,
      'headPortrait': instance.headPortrait,
      'token': instance.token,
      'code': instance.code
    };
