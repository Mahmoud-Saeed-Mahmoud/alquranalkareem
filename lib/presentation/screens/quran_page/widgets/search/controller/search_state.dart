import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/data_source/quran_database.dart';
import '../data/models/search_item.dart';

class SearchState {
  /// -------- [Variables] ----------
  final ScrollController scrollController = ScrollController();
  final searchTextEditing = TextEditingController();
  ContainerTransitionType transitionType = ContainerTransitionType.fade;
  GetStorage box = GetStorage();
  var isLoading = false.obs;
  var ayahList = <QuranTableData>[].obs;
  var surahList = <QuranTableData>[].obs;
  var errorMessage = ''.obs;
  int currentPage = 1;
  int itemsPerPage = 5;
  bool hasMore = true;
  RxList<SearchItem> searchHistory = <SearchItem>[].obs;
}
