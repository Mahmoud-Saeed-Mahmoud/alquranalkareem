import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/extensions.dart';
import '/core/widgets/container_with_lines.dart';
import '../../../../core/utils/constants/lists.dart';
import '../../../../core/widgets/elevated_button_widget.dart';

class ScreensList extends StatelessWidget {
  const ScreensList({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: context.customOrientation(BoxFit.scaleDown, BoxFit.none),
      child: ContainerWithLines(
          width: 390,
          linesColor: Theme.of(context).colorScheme.primary,
          containerColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: .2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(
                  screensList.length,
                  (index) => index == 0
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            Get.to(screensList[index]['route'],
                                transition: Transition.downToUp);
                          },
                          child: ElevatedButtonWidget(
                            index: index,
                            onClick: () => Get.to(screensList[index]['route'],
                                transition: Transition.downToUp),
                            height: 70,
                            width: index == 5
                                ? screensList[index]['width'] - 5
                                : screensList[index]['width'] + 5,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  screensList[index]['svgUrl'],
                                  height: index == 5 ? 35 : 65,
                                ),
                                index == 2 || index == 3
                                    ? const SizedBox.shrink()
                                    : Container(
                                        width: index == 5 ? 190 : 150,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4)),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                width: 1)),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${screensList[index]['name']}'.tr,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'kufi',
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        )),
            ),
          )),
    );
  }
}
