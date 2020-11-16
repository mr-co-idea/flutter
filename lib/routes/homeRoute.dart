import 'package:flutter/material.dart';
import 'package:pipePro/pages/index_pages.dart';

class HomeRoute extends StatefulWidget {
  @override
  HomeRouteState createState() => HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> {
  final List<Widget> _widgetOptions = <Widget>[MapIndex(), null, DataIndex()];
  final List<String> _titleList = <String>["测绘", "业务管理", "数据采集"];
  int _selectedInndex = 0; //默认界面
  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BusinessIndex(),
        ));
      } else {
        _selectedInndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //首页列表
    Widget _buildBottomMenu() {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('测绘')),
          BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('业务管理')),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: Text('数据采集')),
        ],
        currentIndex: _selectedInndex,
        onTap: _onItemTapped,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_titleList[_selectedInndex]),
      ),
      body: _widgetOptions.elementAt(_selectedInndex),
      drawer: MyDrawer(), //抽屉菜单
      bottomNavigationBar: _buildBottomMenu(),
    );
  }
}
