import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:pipePro/common/gloabal.dart';

//缓存机制:通过拦截器实现缓存

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp; //缓存创建的时间

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
} //保存缓存信息

//网络缓存
class NetCache extends Interceptor {
  //保持迭代器和插入时间的顺序一致性，采用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();
  @override
  Future onRequest(RequestOptions options) async {
    if (!Global.profile.cache.enable) return options;
    //refresh标记是否是“下拉”刷新
    bool refresh = options.extra["refresh"] == true;
    //如果是下拉刷新，则清除请求
    if (refresh) {
      if (options.extra["list"]) {
        //如果是列表，则只需要url中包含当前path的缓存全部删掉
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        //如果不是列表，只删除url相同的缓存
        delete(options.uri.toString());
      }
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //缓存未过期，则返回缓存信息
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          //缓存过期,继续向服务器请求
          delete(key);
        }
      }
    }
  } //对缓存方法进行封装

  @override
  onError(DioError err) async {} //错误状态不缓存

  @override
  onResponse(Response response) async {
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
  } //如果启用缓存，则返回结果保存到缓存

  _saveCache(Response object) {
    RequestOptions options = object.request;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      } //如果缓存数量超过最大的数量限制，则先移除最早的一条记录
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }//保存

  void delete(String key) {
    cache.remove(key);
  } //删除缓存
}
