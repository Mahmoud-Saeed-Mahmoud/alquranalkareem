import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/tab_bar_widget.dart';
import '../../../../database/notificationDatabase.dart';
import '../../../controllers/audio_controller.dart';
import '../../../controllers/bookmarks_controller.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/notifications_controller.dart';
import '../../../controllers/translate_controller.dart';
import '../widgets/audio/audio_widget.dart';
import '../widgets/pages/nav_bar_widget.dart';
import '../widgets/pages/screen_switch.dart';
import '../widgets/surah_juz_list.dart';
import '/core/utils/constants/extensions.dart';

class QuranHome extends StatelessWidget {
  QuranHome({Key? key}) : super(key: key);

  final audioCtrl = sl<AudioController>();
  final generalCtrl = sl<GeneralController>();
  final bookmarkCtrl = sl<BookmarksController>();

  bool hasUnopenedNotifications() {
    return sl<NotificationsController>()
        .sentNotifications
        .any((notification) => !notification['opened']);
  }

  @override
  Widget build(BuildContext context) {
    NotificationDatabaseHelper.loadNotifications();
    sl<TranslateDataController>().fetchTranslate(context);
    double width = MediaQuery.sizeOf(context).width;
    final generalCtrl = sl<GeneralController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Get.theme.colorScheme.primary,
      body: SafeArea(
        child: SliderDrawer(
          key: generalCtrl.drawerKey,
          splashColor: Theme.of(context).colorScheme.background,
          slideDirection: generalCtrl.checkRtlLayout(
              SlideDirection.RIGHT_TO_LEFT, SlideDirection.LEFT_TO_RIGHT),
          sliderOpenSize: context.customOrientation(width * .7, width * .8),
          isCupertino: true,
          isDraggable: true,
          appBar: const SizedBox.shrink(),
          slider: SurahJuzList(),
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColorDark,
            ),
            child: Stack(
              children: <Widget>[
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                      child: ScreenSwitch(),
                    )),
                Obx(() => generalCtrl.isShowControl.value
                    ? const TabBarWidget(
                        isChild: true,
                        isIndicator: true,
                      )
                    : const SizedBox.shrink()),
                Obx(() => audioCtrl.isStartPlaying.value ||
                        generalCtrl.isShowControl.value
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: AudioWidget(),
                      )
                    : const SizedBox.shrink()),
                Obx(() => generalCtrl.isShowControl.value
                    ? const Align(
                        alignment: Alignment.bottomCenter,
                        child: NavBarWidget(),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
