import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/index_models.dart';
import './netCache.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
]; //app颜色主题列表

class Global {
  static SharedPreferences _prefs; //持久化存储
  static Profile profile = Profile(); //app描述

  //基础存储
  static NetCache netCache = NetCache(); //网络缓存
  static List<MaterialColor> get themes => _themes; //可选主题列表
  static bool get isRelease =>
      bool.fromEnvironment("dart.vm.product"); //是否为发布版本

  //业务存储
  // static LocatingInformation locatingInformation = LocatingInformation(); //定位信息

  //初始化全局信息，在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString('profile');
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    //如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
  }

  //持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
