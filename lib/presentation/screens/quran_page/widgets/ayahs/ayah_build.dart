import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/convert_number_extension.dart';
import '/core/utils/constants/extensions/surah_name_with_banner.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/widgets/measure_size_widget.dart';
import '../../../../controllers/general_controller.dart';
import '../../../../controllers/quran_controller.dart';
import '../../../../controllers/translate_controller.dart';
import '../pages/custom_span.dart';
import 'ayahs_menu.dart';
import 'translate_build.dart';

class AyahsBuild extends StatelessWidget {
  final int pageIndex;

  AyahsBuild({super.key, required this.pageIndex});

  final quranCtrl = QuranController.instance;

  @override
  Widget build(BuildContext context) {
    sl<TranslateDataController>().loadTranslateValue();
    return ListView.builder(
        // primary: false,
        shrinkWrap: true,
        controller: quranCtrl.ayahsScrollController,
        itemCount:
            quranCtrl.getCurrentPageAyahsSeparatedForBasmalah(pageIndex).length,
        itemBuilder: (context, i) {
          final ayahs =
              quranCtrl.getCurrentPageAyahsSeparatedForBasmalah(pageIndex)[i];
          return Column(children: [
            surahAyahBannerFirstPlace(pageIndex, i),
            Obx(() {
              return Column(
                  children: List.generate(ayahs.length, (ayahIndex) {
                quranCtrl.isSelected = quranCtrl.selectedAyahIndexes
                    .contains(ayahs[ayahIndex].ayahUQNumber);
                return MeasureSizeWidget(
                  onChange: (size) {
                    quranCtrl.ayahsWidgetHeight.value = size.height;
                    // print("Item $ayahIndex size: ${size.height}");
                  },
                  child: Container(
                    key: ValueKey(i),
                    child: GestureDetector(
                      onLongPress: () => quranCtrl
                          .toggleAyahSelection(ayahs[ayahIndex].ayahUQNumber),
                      child: Column(
                        children: [
                          const Gap(16),
                          AyahsMenu(
                            surahNum: quranCtrl.getSurahNumByAyahUQNum(
                                ayahs[ayahIndex].ayahUQNumber),
                            ayahNum: ayahs[ayahIndex].ayahNumber,
                            ayahText: ayahs[ayahIndex].code_v2,
                            pageIndex: pageIndex,
                            ayahTextNormal: ayahs[ayahIndex].text,
                            ayahUQNum: ayahs[ayahIndex].ayahUQNumber,
                            surahName: quranCtrl.surahs
                                .firstWhere(
                                    (s) => s.ayahs.contains(ayahs[ayahIndex]))
                                .arabicName,
                            isSelected: quranCtrl.isSelected,
                            index: ayahIndex,
                          ),
                          const Gap(16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Obx(
                              () => RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'page${pageIndex + 1}',
                                      fontSize: sl<GeneralController>()
                                          .fontSizeArabic
                                          .value,
                                      height: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                    children: [
                                      ayahIndex == 0
                                          ? span(
                                              isFirstAyah: true,
                                              text:
                                                  "${ayahs[ayahIndex].code_v2[0].replaceAll('\n', '')}${ayahs[ayahIndex].code_v2.substring(1).replaceAll('\n', '')}",
                                              pageIndex: pageIndex,
                                              isSelected: quranCtrl.isSelected,
                                              fontSize: sl<GeneralController>()
                                                  .fontSizeArabic
                                                  .value,
                                              surahNum: quranCtrl
                                                  .getSurahNumByAyahUQNum(
                                                      ayahs[ayahIndex]
                                                          .ayahUQNumber),
                                              ayahNum:
                                                  ayahs[ayahIndex].ayahUQNumber,
                                            )
                                          : span(
                                              isFirstAyah: false,
                                              text: ayahs[ayahIndex]
                                                  .code_v2
                                                  .replaceAll('\n', ''),
                                              pageIndex: pageIndex,
                                              isSelected: quranCtrl.isSelected,
                                              fontSize: sl<GeneralController>()
                                                  .fontSizeArabic
                                                  .value,
                                              surahNum: quranCtrl
                                                  .getSurahNumByAyahUQNum(
                                                      ayahs[ayahIndex]
                                                          .ayahUQNumber),
                                              ayahNum:
                                                  ayahs[ayahIndex].ayahUQNumber,
                                            ),
                                    ]),
                              ),
                            ),
                          ),
                          const Gap(16),
                          TranslateBuild(
                            ayahs: ayahs,
                            ayahIndex: ayahIndex,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }));
            }),
            const Gap(32),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 25,
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(8),
                    )),
                child: Text(
                  '${ayahs[i].page.toString().convertNumbers()}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontFamily: 'naskh'),
                ),
              ),
            ),
          ]);
        });
  }
}
