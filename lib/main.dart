import 'package:flutter/material.dart';
import 'data.dart';
import 'detail.dart';
import 'home.dart';
import 'splash_page.dart';
import 'profile_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Nia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        platform: TargetPlatform.iOS,
      ),
      home: SplashPage(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    final path = settings.name!.split('/');
    final title = path[1];   
      Jam jam = jams.firstWhere((it) => it.title == title);
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Detail(jam),
      );
  }
}
