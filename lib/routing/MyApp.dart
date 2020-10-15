import 'package:flutter/material.dart';
import 'package:memo_app/view/Registration.dart';
import 'package:memo_app/view/TopPage.dart';
import 'package:memo_app/view/Detail.dart';
import 'package:memo_app/view/Update.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Memo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: TopPage(title: 'Memo', db: db),
      home: TopPage(title: '一覧', ),
      routes: <String, WidgetBuilder> {
        '/top': (BuildContext context) => new TopPage(),
        '/registration': (BuildContext context) => new Registration(),
        '/update': (BuildContext context) => new Update(),
        '/detail': (BuildContext context) => new Detail(),
      }
    );
  }
}