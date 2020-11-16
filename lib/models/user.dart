import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String identity;
    String userID;
    String headPortrait;
    String token;
    String code;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
