import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/index_common.dart';
import '../../models/index_models.dart';

class LoginRoute extends StatefulWidget {
  @override
  LoginRouteState createState() => LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否明文显示
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _unameController.text = Global.profile.lastLogin;
    print(Global.profile.lastLogin);
    if (_unameController.text != null && _unameController.text != '') {
      _nameAutoFocus = false;
    }
    super.initState();
  } //获取上一次登录用户名

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  return value.trim().isNotEmpty ? null : "请输入用户名";
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  ),
                ),
                obscureText: !pwdShow,
                validator: (value) {
                  return value.trim().isNotEmpty ? null : "请输入密码";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text("登录"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    dynamic showToast(String message) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(message),
                actions: [
                  FlatButton(
                    child: Text("确认"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    }

    dynamic showLoading(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Icon(Icons.cloud_circle),
              ));
    }

    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        // 提交前，先验证各个表单字段是否合法
        user = await NetWork(context)
            .login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          showToast("用户名或密码输入错误");
        } else {
          showToast(e.toString());
        }
      } finally {
        //隐藏loading框
        Navigator.of(context).pop();
      }
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
