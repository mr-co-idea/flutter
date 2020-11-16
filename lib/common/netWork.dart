import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pipePro/common/gloabal.dart';
import '../models/index_models.dart';

class NetWork {
  //在网络请求过程中可能需要使用当前context，例如请求失败时
  //打开一个新路由需要context
  NetWork([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  static void init() {
    dio.interceptors.add(Global.netCache); //添加缓存插件
    dio.options.headers[HttpHeaders.authorizationHeader] =
        Global.profile.token; //设置用户taken（可能为空）

    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY localhost:3000";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) =>
                true; //代理工具会提供一个抓包的自签证书，需要禁用证书验证
      };
    } //在调试模式下抓包调试，所以使用代理，并禁用HTTPS证书校验
  }

  //登录接口，返回登录成功后的用户信息
  Future<User> login(String login, String pwd) async {
    String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
    var result = await dio.get('/login',
        options: _options.merge(
            headers: {HttpHeaders.authorizationHeader: basic},
            extra: {"noCache": true}));
    final String _token = User.fromJson(result.data).token;
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = _token;
    Global.netCache.cache.clear(); //清空所有缓存
    Global.profile.token = _token; //更新profile中的token信息
    return User.fromJson(result.data);
  }

  Future list() async {
    var result = await dio.get('/list');
    print(result);
  }
}
