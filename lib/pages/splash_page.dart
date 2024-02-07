import 'package:cook/pages/add_recipes.dart';
import 'package:cook/pages/recipes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset("assets/food.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 250, 0, 0),
                  child: Text(
                    "Happy Cooking !!",
                    style: TextStyle(
                        color: Color(
                          0xffFEC0A0,
                        ),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(120, 450, 0, 0),
                  child: InkWell(onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AddRecipe()),
                  );},
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(
                          0xffFEC0A0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Go the recipes",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
