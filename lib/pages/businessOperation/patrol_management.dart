import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';
import '../others/please_login.dart';

class PatrolManagement extends StatefulWidget {
  @override
  PatrolManagementState createState() => PatrolManagementState();
}

class PatrolManagementState extends State<PatrolManagement> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      body: user.isLogin ? Text(('巡线管理')) : PleaseLogin(),
    );
  }
}
