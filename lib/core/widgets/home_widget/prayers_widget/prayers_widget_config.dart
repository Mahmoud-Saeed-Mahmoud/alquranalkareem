import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

import '../../../../presentation/controllers/adhan_controller.dart';
import '../../../../presentation/controllers/home_widget_controller.dart';
import '../../../services/services_locator.dart';
import '../../../utils/constants/string_constants.dart';
import 'prayers_home_widget.dart';

class PrayersWidgetConfig {
  final homeWCtrl = HomeWidgetController.instance;
  final adhanCtrl = sl<AdhanController>();

  Future<void> updatePrayersDate() async {
    var path = await HomeWidget.renderFlutterWidget(
      PrayersHomeWidget(),
      key: 'prayerDateImage',
      logicalSize: const Size(353, 300),
      pixelRatio: 7,
    );
    var fajrTime = adhanCtrl.prayerNameList[0]['time'];
    var dhuhrTime = adhanCtrl.prayerNameList[1]['time'];
    var asrTime = adhanCtrl.prayerNameList[2]['time'];
    var maghribTime = adhanCtrl.prayerNameList[3]['time'];
    var ishaTime = adhanCtrl.prayerNameList[4]['time'];

    print('Fajr: $fajrTime');
    print('Dhuhr: $dhuhrTime');
    print('Asr: $asrTime');
    print('Maghrib: $maghribTime');
    print('Isha: $ishaTime');

    HomeWidget.saveWidgetData('fajr', '$fajrTime');
    HomeWidget.saveWidgetData('dhuhr', '$dhuhrTime');
    HomeWidget.saveWidgetData('asr', '$asrTime');
    HomeWidget.saveWidgetData('maghrib', '$maghribTime');
    HomeWidget.saveWidgetData('isha', '$ishaTime');

    sl<HomeWidgetController>().prayersPathImages.value = (path as String?)!;

    DateTime nextPrayerTime = adhanCtrl.getTimeLeftForHomeWidgetNextPrayer();
    String nextPrayerTimeString = nextPrayerTime.toIso8601String();
    log('Next prayer time: $nextPrayerTimeString');
    HomeWidget.saveWidgetData<String>('nextPrayerTime', nextPrayerTimeString);

    HomeWidget.updateWidget(
      iOSName: StringConstants.iosPrayersWidget,
      androidName: StringConstants.androidPrayersWidget,
    );
  }

  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(StringConstants.groupId);
  }
}
