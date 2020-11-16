import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cacheConfig.dart";
import "locatingInformation.dart";
part 'Profile.g.dart';

@JsonSerializable()
class Profile {
    Profile();

    User user;
    String token;
    num theme;
    CacheConfig cache;
    String lastLogin;
    LocatingInformation locatingInformation;
    
    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}