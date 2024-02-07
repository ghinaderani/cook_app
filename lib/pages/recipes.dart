import 'package:cook/bloc/cook_bloc.dart';
import 'package:cook/model/model.dart';
import 'package:cook/pages/Update.dart';
import 'package:cook/pages/page_shared.dart';
import 'package:cook/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

// List<CookModel> foundRecipe = [];
TextEditingController SearchController = TextEditingController();

class _RecipesPageState extends State<RecipesPage> {
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
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchPage()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Search",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   controller:  SearchController,
                    //   onChanged: (value) => runFilter(value),
                    //   decoration: InputDecoration(
                    //     focusColor: Color(
                    //       0xffFEC0A0,
                    //     ),
                    //     labelText: "Search",
                    //     suffixIcon: Icon(Icons.search),
                    //   ),
                    // ),
                    SizedBox(
                      height: 700,
                      child: ListView.builder(
                          itemCount: state.cooking.length,
                          itemBuilder: (context, ind) {
                            // key:
                            // ValueKey(cooking[ind].recipe_name.toString());
                            final Uri url =
                                Uri.parse(state.cooking[ind].video_link);
                            
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
                                          child: Image.network(state
                                              .cooking[ind].thumbnail
                                              .toString()),
                                        ),
                                        title: Text(
                                            state.cooking[ind].recipe_name),
                                        subtitle: TextButton(
                                          onPressed: () {
                                            launchUrl(url);
                                          },
                                          child: Text(
                                              state.cooking[ind].video_link),
                                        ),
                                        //  Text(state.cooking[ind].video_link),
                                        // trailing: Text(state.cooking[ind].duration.toString()),
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Text(state.cooking[ind].duration
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
                                            state.cooking[ind].ingredients
                                                .length,
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
              } 
              else {
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
