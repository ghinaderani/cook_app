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

class LinkPage extends StatefulWidget {
  const LinkPage({super.key});

  @override
  State<LinkPage> createState() => _LinkPageState();
}
TextEditingController SearchController = TextEditingController();

class _LinkPageState extends State<LinkPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CookBloc(),
      child: Builder(builder: (context) {
        context.read<CookBloc>().add(GetRecipes());
        return Scaffold(
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
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: state.cooking.length,
                          itemBuilder: (context, ind) {
                            final controller = WebViewController()
                              ..setJavaScriptMode(JavaScriptMode.disabled)
                              ..loadRequest(
                                  Uri.parse(state.cooking[ind].video_link));
                            return Column(
                              children: [
                                 WebViewWidget(controller: controller),
                                
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
