import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';

//主题界面
class ThmeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("主题"),
        ),
        body: ListView(
          children: Global.themes.map<Widget>((element) {
            return GestureDetector(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Container(
                  color: element,
                  height: 40,
                ),
              ),
              onTap: () {
                Provider.of<ThemeModel>(context,listen: false).theme = element;
              },
            );
          }).toList(),
        ));
  }
}
