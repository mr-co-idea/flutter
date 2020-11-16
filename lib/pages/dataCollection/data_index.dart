import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';
import '../others/please_login.dart';


class DataIndex extends StatefulWidget {
  @override
  DataIndexState createState() => DataIndexState();
}

class DataIndexState extends State<DataIndex> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      body:user.isLogin ? Text(('数据采集')) : PleaseLogin(),
    );
  }
}
