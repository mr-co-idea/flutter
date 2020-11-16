import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Expanded(
                child: _buildMenu(),
              )
            ],
          )),
    );
  }
}

//头像和登录信息
Widget _buildHeader() {
  return Consumer<UserModel>(
    builder: (BuildContext context, UserModel value, Widget child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: value.isLogin
                      ? avatarWidget(value.user.headPortrait, width: 80)
                      : Image.asset(
                          "images/unload.jfif",
                          width: 80,
                        ),
                ),
              ),
              if (value.isLogin)
                Text(value.user.identity)
              else
                FlatButton(
                  child: Text("请登录"),
                  onPressed: () => Navigator.of(context).pushNamed("login"),
                )
            ],
          ),
        ),
      );
    },
  );
}

//抽屉菜单
Widget _buildMenu() {
  return Consumer<UserModel>(
    builder: (BuildContext context, UserModel userModel, Widget child) {
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text("主题"),
            onTap: () => Navigator.of(context).pushNamed('theme'),
          ),
          if (userModel.isLogin)
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text("注销"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('注销'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("取消"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text("确认"),
                            onPressed: () {
                              userModel.user = null;
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              },
            )
        ],
      );
    },
  );
}
