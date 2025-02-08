import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/models/news_list_model.dart';

import 'bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  HomeStatus? status;
  String? error;
  PagingController<int, Articles>? newsListPaginationController;
  TextEditingController? reasonController;

  HomeState({
    this.status,
    this.error,
    this.newsListPaginationController,
    this.reasonController,
  });

  static HomeState initial() {
    return HomeState(
        status: HomeStatus.initial,
        newsListPaginationController:
            PagingController<int, Articles>(firstPageKey: 1),
        reasonController: TextEditingController());
  }

  HomeState clone({
    HomeStatus? status,
    String? error,
    PagingController<int, Articles>? newsListPaginationController,
    TextEditingController? reasonController,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      newsListPaginationController:
          newsListPaginationController ?? this.newsListPaginationController,
      reasonController: reasonController ?? this.reasonController,
    );
  }

  @override
  List<Object?> get props =>
      [status, error, newsListPaginationController, reasonController];
}
