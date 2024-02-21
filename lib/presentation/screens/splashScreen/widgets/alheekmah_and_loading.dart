import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants/lottie.dart';

class AlheekmahAndLoading extends StatelessWidget {
  const AlheekmahAndLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/alheekmah_logo.svg',
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.background, BlendMode.srcIn),
            width: 90,
          ),
          Transform.translate(
            offset: const Offset(0, 30),
            child: RotatedBox(
              quarterTurns: 2,
              child: loading(width: 250.0),
            ),
          ),
        ],
      ),
    );
  }
}
