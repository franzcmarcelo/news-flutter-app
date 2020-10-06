import 'package:flutter/material.dart';
import 'package:provider_news_app/src/pages/tabs_page.dart';
import 'package:provider_news_app/src/theme/dark_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: TabsPage(),
    );
  }
}