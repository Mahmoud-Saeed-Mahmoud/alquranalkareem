import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants/extensions/extensions.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../controllers/azkar_controller.dart';
import '../widgets/options_row.dart';
import '../widgets/text_widget.dart';

class AzkarItem extends StatelessWidget {
  const AzkarItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final azkarCtrl = AzkarController.instance;
    azkarCtrl.getAdhkar();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: const AppBarWidget(isTitled: true),
        body: SafeArea(
          child: Padding(
            padding: context.customOrientation(const EdgeInsets.all(0),
                const EdgeInsets.symmetric(horizontal: 64.0)),
            child: ListView.builder(
                itemCount: azkarCtrl.filteredDhekrList.length,
                itemBuilder: (context, index) {
                  var zekr = azkarCtrl.filteredDhekrList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(32),
                        OptionsRow(
                          zekr: zekr,
                          azkarFav: false,
                        ),
                        TextWidget(
                          zekr: zekr,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
