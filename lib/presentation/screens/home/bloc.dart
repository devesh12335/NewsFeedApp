import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/constants/api_constants.dart';

import 'package:news_app/models/news_list_model.dart';
import 'package:news_app/presentation/screens/view_news/view_news.dart';

import 'event.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<InitEvent>(_init);
    on<ViewNewsEvent>(_viewNews);
  }

  Future<void> _init(InitEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.clone(
        status: HomeStatus.loading,
      ));
      state.newsListPaginationController!.addPageRequestListener((pageKey) {
        _fetchPage(
            pageKey,
            state.reasonController?.text == ""
                ? "bitcoin"
                : state.reasonController?.text ?? "bitcoin");
      });
      state.newsListPaginationController!.refresh();
      emit(state.clone(status: HomeStatus.loaded));
    } catch (e) {
      emit(state.clone(status: HomeStatus.error, error: e.toString()));
      throw e;
    }
  }

  Future<void> _fetchPage(int pageKey, String searchQuery) async {
    final Uri url = Uri.parse(ApiConstants.BASE_URL).replace(queryParameters: {
      "apiKey": "b4ee8644b3f845cc94e93bf9b6db1d62",
      "q": "$searchQuery",
      "page": pageKey.toString(),
      "pageSize": "10",
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final newsData = NewsListModel.fromJson(data);
      int totalPages = (newsData.totalResults ?? 0 / 10).ceil();
      final isLastPage = totalPages < 10;

      if (isLastPage) {
        state.newsListPaginationController!
            .appendLastPage(newsData.articles ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        state.newsListPaginationController!
            .appendPage(newsData.articles ?? [], nextPageKey);
      }
    } else {
      state.newsListPaginationController!.error =
          Exception(json.decode(response.body)["message"]);
      throw Exception('Failed to load news ${response.body}');
    }
  }

  Future<void> _viewNews(ViewNewsEvent event, Emitter<HomeState> emit) async {
    Navigator.of(event.context).push(MaterialPageRoute(
        builder: (context) => NewsViewScreen(url: event.newsUrl)));
  }
}
