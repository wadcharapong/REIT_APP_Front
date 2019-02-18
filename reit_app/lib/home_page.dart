import 'package:flutter/material.dart';
import 'package:reit_app/favorite.dart';

@override
Widget appBarDashbord() {
  return AppBar(
    centerTitle: true,
    title: Text(
      'Dashbord',
      style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 25.0),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.account_circle),
        onPressed: () {},
      ),
    ],
    backgroundColor: Colors.green[600],
  );
}

@override
Widget drawerDashbord() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Menu',
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200,
                fontSize: 20.0),
          ),
          decoration: BoxDecoration(
            color: Colors.green[600],
          ),
        ),
      ],
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDashbord(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 16.0),
            child: Text(
              'Favorite',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.left,
            ),
          ),
          Favorite()
        ],
      ),
      drawer: drawerDashbord(),
    );
  }
}
