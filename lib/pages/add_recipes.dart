import 'package:cook/bloc/add_bloc.dart';
import 'package:cook/model/model.dart';
import 'package:cook/pages/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _formKey = GlobalKey<FormState>();

class AddRecipe extends StatefulWidget {
  AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  // This widget is the root of your application.
  TextEditingController recipe_nameController = TextEditingController();
  TextEditingController thumbnailController = TextEditingController();
  TextEditingController video_linkController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  // TextEditingController idController = TextEditingController();
  List<TextEditingController> ingredientsControllers = [];
  int ListController = 15;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < ListController; i++) {
      ingredientsControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
              child: BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is Success) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Thank you for adding recip"),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(label: "", onPressed: () {}),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipesPage()),
                );
              } else if (state is Error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Error"),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(label: "", onPressed: () {}),
                ));
              } else if (state is Offline) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.grey,
                    action: SnackBarAction(label: "", onPressed: () {}),
                    content: const Text("you are offline"),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        "Add recipe",
                        style: TextStyle(
                            fontSize: 36,
                            color: Color(
                              0xffFEC0A0,
                            ),
                            fontWeight: FontWeight.bold),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                        child: TextFormField(
                          controller: recipe_nameController,
                          decoration: InputDecoration(
                            hintText: 'please enter the recipes name',
                            border: OutlineInputBorder(),
                            label: Text(
                              'recipes name',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the recipes name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: thumbnailController,
                          decoration: InputDecoration(
                            hintText: 'please enter the thumbnail link',
                            border: OutlineInputBorder(),
                            label: Text(
                              'thumbnail link',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the thumbnail link';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: video_linkController,
                          decoration: InputDecoration(
                            hintText: 'please enter the video link',
                            border: OutlineInputBorder(),
                            label: Text(
                              'video link',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the video link';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: durationController,
                          decoration: InputDecoration(
                            hintText: 'please enter the duration',
                            border: OutlineInputBorder(),
                            label: Text(
                              'duration',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the duration';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: ingredientsControllers[0],
                          decoration: InputDecoration(
                            hintText: 'please enter the ingredients',
                            border: OutlineInputBorder(),
                            label: Text(
                              'ingredients',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the ingredients';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            context.read<AddBloc>().add(
                                  Postbloc(
                                    cooked: CookModel(
                                      recipe_name: recipe_nameController.text,
                                      thumbnail: thumbnailController.text,
                                      video_link: video_linkController.text,
                                      duration: durationController.hashCode,
                                    
                                      ingredients: List.generate(
                                        ingredientsControllers.length,
                                        (index) =>
                                            (ingredientsControllers[index]
                                                .text),
                                      ),
                                    ),
                                  ),
                                );
                          },
                          child: Container(
                            height: 59,
                            width: 281,
                            decoration: BoxDecoration(
                              color: Color(
                                0xffFEC0A0,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                                child: Text(
                              "Coniform",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RecipesPage()),
                            );
                          },
                          child: Container(
                            height: 59,
                            width: 281,
                            decoration: BoxDecoration(
                              color: Color(
                                0xffFEC0A0,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                                child: Text(
                              "Skip",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          )),
        );
      }),
    );
  }
}
