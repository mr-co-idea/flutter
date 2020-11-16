import 'package:flutter/material.dart';
import './patrol_management.dart';
import './thirdparty_construction.dart';
import './risk_management.dart';

class BusinessIndex extends StatefulWidget {
  @override
  BusinessIndexState createState() => BusinessIndexState();
}

class BusinessIndexState extends State<BusinessIndex> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    PatrolManagement(),
    ThirdpartyConstruction(),
    RiskManagement()
  ];

  void _tabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<BottomNavigationBarItem> bottomMenus = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.transfer_within_a_station), title: Text('巡线')),
      BottomNavigationBarItem(
          icon: Icon(Icons.assignment), title: Text('第三方施工')),
      BottomNavigationBarItem(
          icon: Icon(Icons.notification_important), title: Text('隐患'))
    ];

    const List<String> _titleList = <String>["巡线管理", "第三方施工", "隐患管理"];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('业务管理：'),
            ),
            Text(_titleList[_selectedIndex], style: TextStyle(fontSize: 16))
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomMenus,
        currentIndex: _selectedIndex,
        onTap: _tabChanged,
      ),
    );
  }
}
