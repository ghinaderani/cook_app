import 'package:cook/config/config.dart';
import 'package:cook/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageShared extends StatelessWidget {
   PageShared({super.key});

  CookModel cook = CookModel.fromJson(config.get<SharedPreferences>().getString('data') ?? "hello");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(cook.recipe_name)),
    );
  }
}