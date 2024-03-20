import 'package:alquranalkareem/core/utils/constants/extensions/extensions.dart';
import 'package:alquranalkareem/core/utils/constants/extensions/surah_name_with_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../presentation/controllers/daily_ayah_controller.dart';
import '../../../presentation/controllers/general_controller.dart';
import '../../services/services_locator.dart';
import '/core/utils/constants/extensions/text_span_extension.dart';
import '/presentation/controllers/ayat_controller.dart';
import '/presentation/controllers/quran_controller.dart';

class AyahTafsirWidget extends StatelessWidget {
  AyahTafsirWidget({super.key});

  final dailyCtrl = sl<DailyAyahController>();
  final ayatCtrl = sl<AyatController>();
  final generalCtrl = sl<GeneralController>();
  final quranCtrl = sl<QuranController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .94,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          )),
      child: Column(
        children: [
          const Gap(8),
          context.customClose(),
          const Gap(16),
          context.surahBannerWidget(quranCtrl
              .getSurahDataByAyahUQ(dailyCtrl.ayahOfTheDay!.ayahUQNumber)
              .surahNumber
              .toString()),
          const Gap(16),
          Flexible(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: ayatCtrl.getTafsir(
                      dailyCtrl.ayahOfTheDay!.ayahUQNumber,
                      quranCtrl
                          .getSurahDataByAyahUQ(
                              dailyCtrl.ayahOfTheDay!.ayahUQNumber)
                          .surahNumber),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? Container(
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(.1),
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Scrollbar(
                                controller: dailyCtrl.scrollController,
                                child: SingleChildScrollView(
                                  controller: dailyCtrl.scrollController,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '﴿${dailyCtrl.ayahOfTheDay!.text} ${generalCtrl.convertNumbers(dailyCtrl.ayahOfTheDay!.ayahNumber.toString())}﴾\n\n',
                                          style: TextStyle(
                                            fontFamily: 'uthmanic2',
                                            fontSize: 24,
                                            height: 1.9,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                        ),
                                        TextSpan(
                                          children: ayatCtrl
                                              .selectedTafsir!.text
                                              .buildTextSpans(),
                                          style: TextStyle(
                                              color: Get.theme.colorScheme
                                                  .inversePrimary,
                                              height: 1.5,
                                              fontSize: sl<GeneralController>()
                                                  .fontSizeArabic
                                                  .value),
                                        ),
                                        WidgetSpan(
                                          child: Center(
                                            child: SizedBox(
                                              height: 50,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1 /
                                                      2,
                                                  child: SvgPicture.asset(
                                                    'assets/svg/space_line.svg',
                                                  )),
                                            ),
                                          ),
                                        )
                                        // TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
