part of '../events.dart';

class HijriCalendarScreen extends StatelessWidget {
  HijriCalendarScreen({super.key});

  final eventsCtrl = EventController.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
        builder: (eventCtrl) => Scaffold(
              backgroundColor: Get.theme.colorScheme.primary,
              body: SafeArea(
                child: Container(
                  color: Get.theme.colorScheme.primaryContainer,
                  child: SlidingBox(
                    controller: eventCtrl.boxController,
                    minHeight: 350,
                    maxHeight: Get.height * .8,
                    color: Colors.transparent,
                    style: BoxStyle.none,
                    physics: const ClampingScrollPhysics(),
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 250),
                    draggableIconVisible: false,
                    collapsed: true,
                    backdrop: Backdrop(
                      fading: false,
                      overlay: false,
                      body: Column(
                        children: [
                          const TabBarWidget(
                            isFirstChild: true,
                            isCenterChild: false,
                            isQuranSetting: false,
                            isNotification: false,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/hijri/${eventsCtrl.hijriNow.hMonth}.svg',
                                        width: 150,
                                        colorFilter: ColorFilter.mode(
                                            Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            BlendMode.srcIn)),
                                    Transform.translate(
                                      offset: const Offset(-70, 30),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Get.theme.colorScheme.primary
                                                .withOpacity(.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4))),
                                        child: Text(
                                          '${eventsCtrl.hijriNow.hYear}'
                                              .convertNumbers(),
                                          style: TextStyle(
                                            fontSize: 34.0,
                                            fontFamily: 'kufi',
                                            height: .5,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    YearSelection(),
                                    const Gap(8),
                                    MonthSelection(),
                                  ],
                                ),
                                const Gap(16),
                                DaysName(),
                                const Gap(8),
                                SizedBox(
                                  height: 200,
                                  child: PageView.builder(
                                    controller: eventCtrl.pageController,
                                    onPageChanged: eventCtrl.onMonthChanged,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: 12,
                                    itemBuilder: (context, monthIndex) {
                                      eventCtrl.calenderMonth.value =
                                          eventCtrl.months[monthIndex];
                                      final daysInMonth = eventCtrl
                                          .calenderMonth.value
                                          .getDaysInMonth(
                                              eventCtrl
                                                  .calenderMonth.value.hYear,
                                              eventCtrl
                                                  .calenderMonth.value.hMonth);
                                      final firstDayWeekday = eventCtrl
                                          .calenderMonth.value
                                          .weekDay();
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: CalendarBuild(
                                          daysInMonth: daysInMonth,
                                          firstDayWeekday: firstDayWeekday,
                                          month: eventCtrl.calenderMonth.value,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Container(
                      // height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          border: Border.all(
                            width: 1,
                            color:
                                Get.theme.colorScheme.surface.withOpacity(.4),
                          )),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, -10),
                                blurRadius: 10,
                                spreadRadius: 10,
                                color: Get.theme.colorScheme.surface
                                    .withOpacity(.2),
                              )
                            ]),
                        child: AllCalculatingEventsWidget(),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}