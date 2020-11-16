import 'package:flutter/material.dart';

class PleaseLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('请登录'),
        onPressed: () => Navigator.of(context).pushNamed("login"),
      ),
    );
  }
}
