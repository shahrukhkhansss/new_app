import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/menu_data_provider.dart';
import 'ui/news_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<menuDataProvider>(
      create: (_) => menuDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: NewsPage(),
    );
  }
}
