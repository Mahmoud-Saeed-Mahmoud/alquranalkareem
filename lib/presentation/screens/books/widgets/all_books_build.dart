import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/extensions.dart';
import '/core/utils/constants/extensions/svg_extensions.dart';
import '../../../../core/utils/constants/svg_constants.dart';
import '../controller/books_controller.dart';
import '../screens/chapters_screen.dart';

class AllBooksBuild extends StatelessWidget {
  AllBooksBuild({super.key});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (booksCtrl.state.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      final allBooks = booksCtrl.state.booksList;
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'allBooks'.tr,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'kufi',
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
              allBooks.length,
              (index) {
                final book = allBooks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 110.h,
                      width: context.definePlatform(95.w, 85.0),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: .1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Hero(
                            tag: 'book-tag:${book.bookNumber}',
                            child: customSvg(SvgPath.svgRightBook),
                          ),
                          SizedBox(
                            height: 60.h,
                            width: context.definePlatform(60.w, 50.0),
                            child: Text(
                              book.bookName,
                              style: TextStyle(
                                fontSize: context.definePlatform(12.0.sp, 12.0),
                                fontFamily: 'kufi',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor,
                                height: 1.5,
                              ),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(
                        () => ChaptersPage(
                          bookNumber: book.bookNumber,
                          bookName: book.bookName,
                          aboutBook: book.aboutBook,
                        ),
                        transition: Transition.downToUp,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          context.hDivider(width: Get.width),
        ],
      );
    });
  }
}
