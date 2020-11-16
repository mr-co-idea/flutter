import 'package:flutter/material.dart';
import 'package:pipePro/models/index_models.dart';
import './gloabal.dart';

//共享状态
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更

    super.notifyListeners(); //通知涉及的Wiget更新
  }
}

//用户状态
class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  bool get isLogin => user != null; //判断App是否为空

  set user(User user) {
    if (user?.identity != _profile.user?.identity) {
      _profile.lastLogin = _profile.user?.identity;
      _profile.user = user;
      notifyListeners();
    }
  } //用户状态发生改变，依赖的Widget更新

} //用户状态在登录状态发生变化是更新，通知其依赖项

//app主题状态
class ThemeModel extends ProfileChangeNotifier {
  ColorSwatch get theme =>
      Global.themes.firstWhere((element) => element.value == _profile.theme,
          orElse: () => Colors.blue); //获取当前主题，如果为设置主题，则默认为蓝色主题

  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

//定位信息
class LocationModel extends ProfileChangeNotifier {
  LocatingInformation get locatingInformation => _profile.locatingInformation;

  set locatingInformation(LocatingInformation locatingInformation) {
    if (locatingInformation.code != 0) {
      _profile.locatingInformation = locatingInformation;
      notifyListeners();
    }
  } //更改定位信息
} //定位信息获取后或改变后，更新依赖它的Widget
