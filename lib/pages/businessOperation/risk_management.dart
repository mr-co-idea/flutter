import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';
import '../others/please_login.dart';

class RiskManagement extends StatefulWidget {
  @override
  RiskManagementState createState() => RiskManagementState();
}

class RiskManagementState extends State<RiskManagement> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      body: user.isLogin ? Text(('隐患管理')) : PleaseLogin(),
    );
  }
}
