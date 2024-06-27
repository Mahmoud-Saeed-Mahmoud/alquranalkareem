import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '/core/utils/constants/extensions/convert_number_extension.dart';
import '/core/utils/constants/extensions/extensions.dart';
import '/core/utils/constants/extensions/font_size_extension.dart';
import '../../../../controllers/audio_controller.dart';
import '../../../../controllers/general_controller.dart';
import '../../../../controllers/quran_controller.dart';
import 'ayah_build.dart';

class AyahsWidget extends StatelessWidget {
  AyahsWidget({
    super.key,
  });

  final quranCtrl = QuranController.instance;
  final audioCtrl = AudioController.instance;
  final generalCtrl = GeneralController.instance;

  @override
  Widget build(BuildContext context) {
    // quranCtrl.listenToScrollPositions();
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          const Gap(4),
          Container(
            height: 45,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.primaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surface.withOpacity(.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Row(
                    children: [
                      Obx(() => Text(
                            quranCtrl.getSurahNameFromPage(
                                quranCtrl.currentListPage.value),
                            style: TextStyle(
                                fontSize: context.customOrientation(18.0, 22.0),
                                fontFamily: 'naskh',
                                color: Theme.of(context).hintColor),
                          )),
                      Obx(
                        () => Text(
                          ' | ${'juz'.tr}: ${quranCtrl.pages[quranCtrl.currentListPage.value + 1].first.juz.toString().convertNumbers()}',
                          style: TextStyle(
                              fontSize: context.customOrientation(18.0, 22.0),
                              fontFamily: 'naskh',
                              color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  ),
                ),
                fontSizeDropDown(
                    height: 25.0,
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(.7)),
              ],
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                audioCtrl.clearSelection();
              },
              child: quranCtrl.pages.isEmpty
                  ? const CircularProgressIndicator.adaptive()
                  : ScrollablePositionedList.builder(
                      shrinkWrap: false,
                      initialScrollIndex:
                          generalCtrl.currentPageNumber.value - 1,
                      itemScrollController: quranCtrl.itemScrollController,
                      itemPositionsListener: quranCtrl.itemPositionsListener,
                      scrollOffsetController: quranCtrl.scrollOffsetController,
                      itemCount: quranCtrl.pages.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, pageIndex) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.5),
                              )),
                          child: AyahsBuild(
                            pageIndex: pageIndex,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
