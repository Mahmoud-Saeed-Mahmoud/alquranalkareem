import 'dart:developer';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '/core/utils/constants/extensions/custom_error_snackBar.dart';
import '/presentation/screens/books/controller/extensions/books_getters.dart';
import '/presentation/screens/books/controller/extensions/books_storage_getters.dart';
import '../../../../../core/utils/constants/shared_preferences_constants.dart';
import '../../screens/read_view_screen.dart';
import '../books_controller.dart';

extension BooksUi on BooksController {
  /// -------- [onTap] --------
  Future<void> moveToBookPage(String chapterName, int bookNumber) async {
    if (isBookDownloaded(bookNumber)) {
      int initialPage = await getChapterStartPage(bookNumber, chapterName);
      state.currentPageNumber.value = initialPage;
      log('Initial page for chapter $chapterName: $initialPage');
      Get.to(() => PagesPage(bookNumber: bookNumber));
    } else {
      Get.context!.showCustomErrorSnackBar('downloadBookFirst'.tr);
    }
  }

  Future<void> moveToPage(String chapterName, int bookNumber) async {
    if (isBookDownloaded(bookNumber)) {
      int initialPage = await getChapterStartPage(bookNumber, chapterName);
      state.currentPageNumber.value = initialPage;
      log('Initial page for chapter $chapterName: $initialPage');
      state.quranPageController.animateToPage(initialPage,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      Get.context!.showCustomErrorSnackBar('downloadBookFirst'.tr);
    }
  }

  void isTashkilOnTap() {
    state.isTashkil.value = !state.isTashkil.value;
    state.box.write(IS_TASHKIL, state.isTashkil.value);
  }

  Future<void> deleteBook(int bookNumber) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$bookNumber.json');
      if (await file.exists()) {
        await file.delete();
        state.downloaded[bookNumber] = false;
        saveDownloadedBooks();
        log('Book $bookNumber deleted successfully.');

        // حذف آخر قراءة خاصة بالكتاب
        state.box.remove('lastRead_$bookNumber');
        state.lastReadPage.remove(bookNumber);
        state.bookTotalPages.remove(bookNumber);
        log('Last read data for book $bookNumber deleted successfully.');
      }
    } catch (e) {
      log('Error deleting book: $e');
    }
  }
}
