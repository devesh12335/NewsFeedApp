import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/global_state/globalState.dart';
import 'package:news_app/presentation/resources/theme/theme_manager.dart';
import 'package:intl/intl.dart';

import '../../../generated/assets.dart';
import '../../../models/news_list_model.dart';
import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  bool isDarkMode;
  HomePage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(InitEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
            case HomeStatus.loaded:
            case HomeStatus.error:
            case null:
          }
        },
        builder: (context, state) {
          return _buildPage(context, state, isDarkMode);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, HomeState state, bool isDarkMode) {
    //print("${state.status}");
    switch (state.status) {
      case HomeStatus.initial:
        return const Scaffold(
          body: Center(child: Text("Initial__")),
        );
      case HomeStatus.loading:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );

      case HomeStatus.loaded:
        //print(":call loaded");
        return Page(
          state: state,
          isDarkMode: isDarkMode,
        );

      case HomeStatus.error:
        //print(":call loaded");
        return Scaffold(
          body: Center(
            child: Text("${state.error}"),
          ),
        );

      default:
        return const Scaffold(
          body: Center(child: Text("Home default")),
        );
    }
  }
}

class Page extends StatelessWidget {
  HomeState state;
  bool isDarkMode;
  Page({required this.state, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.assetsAppLogo),
          ),
          centerTitle: false,
          title: Text("News Feeds"),
          actions: [
            Icon(Icons.wb_sunny),
            Switch(
              value: GlobalState.instance.isDarkMode.value,
              onChanged: (value) {
                saveThemePreference(value);
                loadThemePreference();
              },
            ),
            Icon(Icons.nightlight_round),
            SizedBox(
              width: 10,
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              padding: EdgeInsets.all(10),
              width: scWidth,
              child: TextField(
                controller: state.reasonController,
                decoration: InputDecoration(
                  hintText: "Search News",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // context.read<HomeBloc>().add(SearchNewsEvent(
                      //     searchQuery: state.reasonController!.text,
                      //     context: context));

                      context.read<HomeBloc>().add(InitEvent());
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(InitEvent());
            return Future.value();
          },
          child: PagedListView<int, Articles>(
            pagingController: state.newsListPaginationController!,
            builderDelegate: PagedChildBuilderDelegate<Articles>(
              newPageErrorIndicatorBuilder: (context) => Center(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child:
                        Text("${state.newsListPaginationController!.error}")),
              ), 
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child:
                        Text("${state.newsListPaginationController!.error}")),
              ),
              itemBuilder: (context, item, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => context.read<HomeBloc>().add(
                      ViewNewsEvent(context: context, newsUrl: item.url ?? "")),
                  minVerticalPadding: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Text(
                    item.title ?? "Not Found",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.description ?? "Not Found",
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 10),
                      ),
                      Divider(),
                      Text(
                        "${item.author ?? "Not Found"} - ${item.source?.name ?? "Not Found"}",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        formatDate(
                          "${item.publishedAt ?? "Not Found"}",
                        ),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                  leading: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      width: 100,
                      height: 300,
                      fit: BoxFit.cover,
                      item.urlToImage ?? "https://via.placeholder.com/150",
                      errorBuilder: (context, error, stackTrace) => Container(
                        child: Icon(
                          Icons.newspaper,
                          size: 50,
                        ),
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
}
