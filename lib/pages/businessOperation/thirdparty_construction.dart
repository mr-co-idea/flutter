import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';
import '../others/please_login.dart';

class ThirdpartyConstruction extends StatefulWidget {
  @override
  ThirdpartyConstructionState createState() => ThirdpartyConstructionState();
}

class ThirdpartyConstructionState extends State<ThirdpartyConstruction> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      body: user.isLogin ? Text(('第三方施工管理')) : PleaseLogin(),
    );
  }
}
