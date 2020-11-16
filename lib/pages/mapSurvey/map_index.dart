import 'package:flutter/material.dart';
import 'package:pipePro/util/h5view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/index_common.dart';
import '../others/please_login.dart';

class MapIndex extends StatefulWidget {
  @override
  MapIndexState createState() => MapIndexState();
}

class MapIndexState extends State<MapIndex> {
  WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      // body: user.isLogin ? Text(('巡检')) : PleaseLogin(),
      body: user.isLogin
          ? H5View(
              initialUrl: 'https://youzan.github.io/vant-weapp/#/intro',
              onWebViewCreated: (WebViewController webViewController) {
                webViewController.loadUrl('');
              },
            )
          : PleaseLogin(),
    );
  }
}
