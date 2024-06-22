import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/books_controller.dart';
import '../screens/read_view_screen.dart';

class BooksChapterBuild extends StatelessWidget {
  final int bookNumber;
  BooksChapterBuild({super.key, required this.bookNumber});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    final parts = booksCtrl.getParts(bookNumber);
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(.15),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
              children: [
                Container(
                  height: 32,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text(
                    'chapterBook'.tr,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: List.generate(parts.length, (index) {
                      final part = parts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: ExpansionTile(
                          collapsedIconColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          collapsedBackgroundColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.1),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.1),
                          title: Text(
                            'الجزء ${part.partNumber}',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'kufi',
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          children: part.chapters.map((chapter) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4.0),
                              child: GestureDetector(
                                onTap: () async {
                                  int initialPage =
                                      await booksCtrl.getChapterStartPage(
                                          bookNumber, chapter.chapterName);
                                  log('Initial page for chapter ${chapter.chapterName}: $initialPage');
                                  Get.to(() => PagesPage(
                                      bookNumber: bookNumber,
                                      initialPage: initialPage));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface
                                            .withOpacity(.6),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.menu,
                                            size: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 9,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                child: Text(
                                                  chapter.chapterName,
                                                  style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontFamily: 'naskh',
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .inversePrimary,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                )))
                                      ],
                                    )),
                              ),
                            );
                          }).toList(),

                          // else {
                          //   return const SizedBox.shrink();
                          // }
                        ),
                      );
                    }),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
