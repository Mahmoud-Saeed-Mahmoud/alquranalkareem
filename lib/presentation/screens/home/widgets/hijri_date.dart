import 'package:alquranalkareem/core/utils/constants/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/convert_number_extension.dart';
import '../../../../core/widgets/elevated_button_widget.dart';
import '../../../../core/widgets/events/events.dart';
import '../../../controllers/general/general_controller.dart';

class HijriDate extends StatelessWidget {
  final generalCtrl = GeneralController.instance;

  final eventCtrl = EventController.instance;
  HijriDate({super.key});

  @override
  Widget build(BuildContext context) {
    generalCtrl.updateGreeting();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButtonWidget(
        onClick: () => Get.to(() => HijriCalendarScreen(),
            transition: Transition.downToUp),
        index: 1,
        height: 190,
        width: context.customOrientation(Get.width * .91, Get.width * .45),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.surface,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 8.0),
              //     child: Text(
              //       '| ${sl<GeneralController>().greeting.value} |',
              //       style: TextStyle(
              //         fontSize: 16.0,
              //         fontFamily: 'kufi',
              //         color: Theme.of(context).hintColor,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          child: Transform.translate(
                            offset: const Offset(0, 4),
                            child: Text(
                              '${generalCtrl.state.today.hDay}'
                                  .convertNumbers(),
                              style: TextStyle(
                                fontSize: 26.0,
                                fontFamily: 'kufi',
                                color: Theme.of(context).canvasColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${generalCtrl.state.today.dayWeName}'.tr,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'kufi',
                                  color: Theme.of(context).canvasColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${'${generalCtrl.state.today.hYear}'.convertNumbers()} هـ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'kufi',
                                  color: Theme.of(context).canvasColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SvgPicture.asset(
                        'assets/svg/hijri/${generalCtrl.state.today.hMonth}.svg',
                        height: 90,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).canvasColor, BlendMode.srcIn)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    LinearProgressIndicator(
                      minHeight: 40,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      value: (generalCtrl.state.today.hDay /
                          generalCtrl.state.today.lengthOfMonth),
                      backgroundColor: Theme.of(context).canvasColor,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: eventCtrl.isLastDayOfMonth
                            ? Text(
                                '${'lastDayOf'.tr} ${'${generalCtrl.state.today.longMonthName}'.tr}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'kufi',
                                  color: Theme.of(context).disabledColor,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '${'RemainsUntilTheEndOf'.tr} ${'${generalCtrl.state.today.longMonthName}'.tr}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'kufi',
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    flex: 3,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '${generalCtrl.state.today.lengthOfMonth - generalCtrl.state.today.hDay} ${'${eventCtrl.daysArabicConvert(generalCtrl.state.today.lengthOfMonth - generalCtrl.state.today.hDay)}'.tr}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'kufi',
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
