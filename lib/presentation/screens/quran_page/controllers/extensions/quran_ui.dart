import 'package:alquranalkareem/presentation/screens/quran_page/controllers/extensions/quran_getters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/constants/shared_preferences_constants.dart';
import '../../../../../core/utils/helpers/global_key_manager.dart';
import '../../../../controllers/general_controller.dart';
import '../audio/audio_controller.dart';
import '../ayat_controller.dart';
import '../bookmarks_controller.dart';
import '../playList_controller.dart';
import '../quran/quran_controller.dart';

extension QuranUi on QuranController {
  /// -------- [onTap] --------
  Widget textScale(dynamic widget1, dynamic widget2) {
    if (state.scaleFactor.value <= 1.0) {
      return widget1;
    } else {
      return widget2;
    }
  }

  void switchMode(int newMode) {
    state.isPages.value = newMode;
    state.selectMushafSettingsPage.value = newMode;
    state.box.write(SWITCH_VALUE, newMode);
    Get.back();
    update();
    if (newMode == 1) {
      Future.delayed(const Duration(milliseconds: 600)).then((_) {
        if (state.itemScrollController.isAttached) {
          state.itemScrollController.jumpTo(
            index: state.currentPageNumber.value - 1,
          );
        }
      });
    } else {
      state.currentPageNumber.value =
          state.itemPositionsListener.itemPositions.value.last.index + 1;
    }
  }

  void changeSurahListOnTap(int page) {
    state.currentPageNumber.value = page - 1;
    if (state.isPages == 1) {
      state.itemScrollController.jumpTo(
        index: page - 1,
      );
    } else {
      state.quranPageController.animateToPage(
        page - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
    GlobalKeyManager().drawerKey.currentState!.closeSlider();
  }

  void toggleAyahSelection(int index) {
    if (state.selectedAyahIndexes.contains(index)) {
      state.selectedAyahIndexes.remove(index);
    } else {
      state.selectedAyahIndexes.clear();
      state.selectedAyahIndexes.add(index);
      state.selectedAyahIndexes.refresh();
    }
    state.selectedAyahIndexes.refresh();
  }

  void clearAndAddSelection(int index) {
    state.selectedAyahIndexes.clear();
    state.selectedAyahIndexes.add(index);
    state.selectedAyahIndexes.refresh();
  }

  void showControl() {
    generalCtrl.isShowControl.value = !generalCtrl.isShowControl.value;
  }

  void toggleMenu(String verseKey) {
    var currentState = state.moreOptionsMap[verseKey] ?? false;
    state.moreOptionsMap[verseKey] = !currentState;
    state.moreOptionsMap.forEach((key, value) {
      if (key != verseKey) state.moreOptionsMap[key] = false;
    });
    update();
  }

  Future<void> pageChanged(int index) async {
    state.currentPageNumber.value = index + 1;
    sl<PlayListController>().reset();
    sl<GeneralController>().isShowControl.value = false;
    sl<AyatController>().isSelected.value = (-1.0);
    sl<AudioController>().state.pageAyahNumber = '0';
    sl<BookmarksController>().getBookmarks();
    state.lastReadSurahNumber.value =
        sl<QuranController>().getSurahNumberFromPage(index);
    state.box.write(MSTART_PAGE, index + 1);
    state.box.write(MLAST_URAH, state.lastReadSurahNumber.value);
  }
}
