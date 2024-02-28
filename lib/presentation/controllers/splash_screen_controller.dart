import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/lists.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../screens/screen_type.dart';
import '../screens/whats_new/whats_new_screen.dart';
import '/presentation/controllers/quran_controller.dart';
import '/presentation/controllers/translate_controller.dart';
import 'audio_controller.dart';
import 'ayat_controller.dart';
import 'general_controller.dart';
import 'settings_controller.dart';

class SplashScreenController extends GetxController {
  RxBool animate = false.obs;
  final sharedCtrl = sl<SharedPreferences>();
  RxInt onboardingPageNumber = 0.obs;

  @override
  void onInit() {
    sl<AyatController>().loadTafseer();
    sl<TranslateDataController>().loadTranslateValue();
    sl<SettingsController>().loadLang();
    sl<AudioController>().loadQuranReader();
    sl<GeneralController>().getLastPageAndFontSize();
    sl<GeneralController>().updateGreeting();
    sl<QuranController>().loadSwitchValue();
    sl<GeneralController>().screenSelectedValue.value =
        sl<SharedPreferences>().getInt(SCREEN_SELECTED_VALUE) ?? 0;
    startTime();
    super.onInit();
  }

  Future startTime() async {
    await Future.delayed(const Duration(seconds: 1));
    animate.value = true;
    await Future.delayed(const Duration(seconds: 3));
    // Get.off(() => OnboardingScreen());
    navigationPage();
  }

  void navigationPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Map<String, dynamic>> newFeatures = await getNewFeatures();
      if (newFeatures.isNotEmpty) {
        Get.bottomSheet(
          WhatsNewScreen(
            newFeatures: newFeatures,
          ),
          isScrollControlled: true,
        );
      } else {
        Get.off(() => const ScreenTypeL());
      }
    });
    // Get.off(() => OnboardingScreen());
    // Navigator.of(context).pushReplacementNamed(routeName);
  }

  Future<void> saveLastShownIndex(int index) async {
    await sharedCtrl.setInt(LAST_SHOWN_UPDATE_INDEX, index);
  }

  Future<int> getLastShownIndex() async {
    return sharedCtrl.getInt(LAST_SHOWN_UPDATE_INDEX) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getNewFeatures() async {
    int lastShownIndex = await getLastShownIndex();

    List<Map<String, dynamic>> newFeatures = whatsNewList.where((item) {
      return item['index'] > lastShownIndex;
    }).toList();

    return newFeatures;
  }

  void showWhatsNew() async {
    List<Map<String, dynamic>> newFeatures = await getNewFeatures();
    if (newFeatures.isNotEmpty) {
      // Code to display new features to the user, e.g., through a dialog or a new screen

      // After displaying, update the last shown index
      await saveLastShownIndex(newFeatures.last['index']);
    }
  }
}
