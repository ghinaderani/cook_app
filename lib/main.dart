import 'package:cook/bloc/cook_bloc.dart';
import 'package:cook/config/config.dart';
import 'package:cook/observe.dart';
import 'package:cook/pages/Update.dart';
import 'package:cook/pages/add_recipes.dart';
import 'package:cook/pages/recipes.dart';
import 'package:cook/pages/splash_page.dart';
// import 'package:cook/tools/web_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    // routes: {
    //   '/': (context)=> SplashPage(),
    //   '/webViewContainer': (context)=> WebViewContainer() ,
    // },
      home: 
      SplashPage(),
      
    );
  }
}
