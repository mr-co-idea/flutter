import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/index_common.dart';
import 'routes/homeRoute.dart';
import './pages/index_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocationModel())
      ],
      child: Consumer<ThemeModel>(
          builder: (BuildContext context, themeModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: themeModel.theme),
          title: '巡检',
          home: HomeRoute(),
          routes: <String, WidgetBuilder>{
            "login": (context) => LoginRoute(),
            "theme": (context) => ThmeChangeRoute(),
          },
        );
      }),
    );
  }
}
