import 'package:cook/bloc/cook_bloc.dart';
import 'package:cook/model/model.dart';
import 'package:cook/pages/Update.dart';
import 'package:cook/pages/page_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<CookModel> foundRecipe = [];
TextEditingController SearchController = TextEditingController();

class _SearchPageState extends State<SearchPage> {
  // List<CookModel> cooking = [CookModel(
  //     recipe_name: '',
  //     thumbnail: '',
  //     video_link: '',
  //     duration: 0,
  //     ingredients: [])];

  // @override
  // void initState() {
  //   foundRecipe = state.cooking;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CookBloc(),
      child: Builder(builder: (context) {
        context.read<CookBloc>().add(GetRecipes());
        return Scaffold(
          // appBar: AppBar(
          //   title: IconButton(
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => PageShared()));
          //       },
          //       icon: Icon(Icons.ad_units)),
          // ),
          backgroundColor: Color(
            0xffFEC0A0,
          ),
          body: BlocBuilder<CookBloc, CookState>(
            builder: (context, state) {
              if (state is Error) {
                return Center(
                  child: Text('Error'),
                );
              } else if (state is Success) {
                void runFilter(dynamic enteredKeyword) {
                  List<CookModel> results = [];
                  if (enteredKeyword.isEmpty) {
                    results = state.cooking;
                  } else {
                    results = state.cooking
                        .where((cook) => cook.recipe_name
                            .toLowerCase()
                            .contains(enteredKeyword.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    foundRecipe = results;
                  });
                }

                return Column(
                  children: [
                    Container(
                      color: Color(
                        0xffFEC0A0,
                      ),
                      child: TextFormField(
                        controller: SearchController,
                        onChanged: (value) => runFilter(value),
                        decoration: InputDecoration(
                          fillColor: Color(
                            0xffFEC0A0,
                          ),
                          labelText: "Search",
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 50),
                    // child: SizedBox(
                    // width: 500,
                    // height: 270,
                    // child: Center(child: Image.asset('assets/text.jpg'))
                    // ),
                    // ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: foundRecipe.length,
                          itemBuilder: (context, ind) {
                            // key:
                            // ValueKey(cooking[ind].recipe_name.toString());
                            final Uri url =
                                Uri.parse(foundRecipe[ind].video_link);
                            return Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  child: InkWell(
                                    onLongPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Update()),
                                      );
                                    },
                                    child: ExpansionTile(
                                        collapsedBackgroundColor: Colors.white,
                                        leading: Container(
                                          height: 300,
                                          width: 100,
                                          child: Image.network(foundRecipe[ind]
                                              .thumbnail
                                              .toString()),
                                        ),
                                        title:
                                            Text(foundRecipe[ind].recipe_name),
                                        subtitle: TextButton(
                                          onPressed: () {
                                            launchUrl(url);
                                          },
                                          child:
                                              Text(foundRecipe[ind].video_link),
                                        ),
                                        //  Text(foundRecipe[ind].video_link),
                                        // trailing: Text(foundRecipe[ind].duration.toString()),
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Text(foundRecipe[ind]
                                                    .duration
                                                    .toString()),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.timer_sharp,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...List.generate(
                                            foundRecipe[ind].ingredients.length,
                                            (index) => ListTile(
                                              title: Text(state.cooking[ind]
                                                  .ingredients[index]),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  //  List.generate(
                                  //     state.cooking.length,
                                  //     (index) =>  ListTile(
                                  //       title: Image.network(state
                                  //               .cooking[ind].thumbnail.toString()),
                                  //       subtitle: Column(
                                  //         children: [
                                  //           Text(state.cooking[ind].ingredients[index]),
                                  //           Text(state.cooking[ind].video_link),
                                  //           Text(state.cooking[ind].duration.toString()),
                                  //         ],
                                  //       ),)),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            loadingCard(),
                            loadingCard(),
                            loadingCard(),
                            loadingCard(),
                            loadingCard(),
                            loadingCard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

Shimmer loadingCard() {
  return Shimmer.fromColors(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ],
            ))
          ],
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100);
}
