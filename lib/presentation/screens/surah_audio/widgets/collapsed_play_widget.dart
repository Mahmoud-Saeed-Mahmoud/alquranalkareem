import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/svg_extensions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/extensions/extensions.dart';
import '../../../../core/utils/constants/svg_constants.dart';
import '../../quran_page/extensions/surah_name_with_banner.dart';
import '../controller/surah_audio_controller.dart';
import 'online_play_button.dart';
import 'skip_next.dart';
import 'skip_previous.dart';

class CollapsedPlayWidget extends StatelessWidget {
  const CollapsedPlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: context.customOrientation(width, width * .5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(.15),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: .6,
                child: customSvg(
                  SvgPath.svgDecorations,
                  height: 60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RotatedBox(
                quarterTurns: 2,
                child: Opacity(
                  opacity: .6,
                  child: customSvg(
                    SvgPath.svgDecorations,
                    height: 60,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      SkipToPrevious(),
                      OnlinePlayButton(
                        isRepeat: false,
                      ),
                      SkipToNext(),
                    ],
                  ),
                  Obx(
                    () => surahNameWidget(
                      sl<SurahAudioController>().state.surahNum.toString(),
                      Get.theme.colorScheme.primary,
                      height: 50,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
