import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart' as R;

import '/presentation/screens/quran_page/controllers/extensions/quran_getters.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/constants/lists.dart';
import '../../../../../core/utils/constants/url_constants.dart';
import '../../../../../core/widgets/seek_bar.dart';
import '../../../../controllers/general_controller.dart';
import '../audio/audio_controller.dart';
import '../ayat_controller.dart';
import '../quran/quran_controller.dart';

// AudioState state = AudioState();
final generalCtrl = GeneralController.instance;
final quranCtrl = QuranController.instance;
final ayatCtrl = AyatController.instance;

extension AudioGetters on AudioController {
  /// -------- [Getters] ----------

  MediaItem get mediaItemForCurrentAyah => MediaItem(
        id: '${state.currentAyahUQInPage.value}',
        title:
            '${sl<QuranController>().getPageAyahsByIndex(generalCtrl.currentPageNumber.value - 1).firstWhere((a) => a.ayahUQNumber == state.currentAyahUQInPage.value).text}',
        artist: '${ayahReaderInfo[state.readerIndex.value]['name']}'.tr,
        artUri: state.cachedArtUri,
      );

  List<MediaItem> get mediaItemsForCurrentSurah {
    final ayahsOfCrntSurah =
        quranCtrl.state.surahs[currentSurahNumInPage - 1].ayahs;
    return List.generate(
        ayahsOfCrntSurah.length,
        (i) => MediaItem(
              id: '${ayahsOfCrntSurah[i].ayahUQNumber}',
              title: '${ayahsOfCrntSurah[i].text}',
              artist: '${ayahReaderInfo[state.readerIndex.value]['name']}'.tr,
              artUri: state.cachedArtUri,
            ));
  }

  int get currentAyahInPage => state.selectedAyahNum.value == 1
      ? quranCtrl.state.allAyahs
          .firstWhere(
              (ayah) => ayah.page == generalCtrl.currentPageNumber.value)
          .ayahNumber
      : state.selectedAyahNum.value;

  int get currentSurahNumInPage => state.currentSurahNumInPage.value == 1
      ? quranCtrl.getSurahNumberFromPage(generalCtrl.currentPageNumber.value)
      : state.currentSurahNumInPage.value;

  Stream<PositionData> get positionDataStream =>
      R.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          state.audioPlayer.positionStream,
          state.audioPlayer.bufferedPositionStream,
          state.audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  bool get isLastAyahInPage =>
      quranCtrl
          .getPageAyahsByIndex(generalCtrl.currentPageNumber.value - 1)
          .last
          .ayahUQNumber ==
      state.currentAyahUQInPage.value;

  bool get isFirstAyahInPage =>
      quranCtrl
          .getPageAyahsByIndex(generalCtrl.currentPageNumber.value - 1)
          .first
          .ayahUQNumber ==
      state.currentAyahUQInPage.value;

  bool get isLastAyahInSurah =>
      quranCtrl
          .getCurrentSurahByPage(generalCtrl.currentPageNumber.value - 1)
          .ayahs
          .last
          .ayahUQNumber ==
      state.currentAyahUQInPage.value;

  bool get isFirstAyahInSurah =>
      quranCtrl
          .getCurrentSurahByPage(generalCtrl.currentPageNumber.value - 1)
          .ayahs
          .first
          .ayahUQNumber ==
      state.currentAyahUQInPage.value;

  bool get isLastAyahInSurahButNotInPage =>
      isLastAyahInSurah && !isLastAyahInPage;

  bool get isLastAyahInSurahAndPage => isLastAyahInSurah && isLastAyahInPage;

  bool get isLastAyahInPageButNotInSurah =>
      isLastAyahInPage && !isLastAyahInSurah;

  bool get isFirstAyahInPageButNotInSurah =>
      isFirstAyahInPage && !isFirstAyahInSurah;

  String get reader => state.readerValue!;

  String get currentAyahFileName {
    if (ayahReaderInfo[state.readerIndex.value]['url'] ==
        UrlConstants.ayahs1stSource) {
      return '$reader/${state.currentAyahUQInPage.value}.mp3';
    } else {
      final surahNum = quranCtrl
          .getSurahNumberByAyah(
              quranCtrl.state.allAyahs[state.currentAyahUQInPage.value - 1])
          .surahNumber
          .toString()
          .padLeft(3, '0');
      final currentAyahNumber = quranCtrl
          .state.allAyahs[state.currentAyahUQInPage.value - 1].ayahNumber
          .toString()
          .padLeft(3, '0');
      return '$reader/$surahNum$currentAyahNumber.mp3';
    }
  }

  List<int> get selectedSurahAyahsUniqueNumbers =>
      quranCtrl.state.surahs[currentSurahNumInPage - 1].ayahs
          .map((ayah) => ayah.ayahUQNumber)
          .toList();

  List<String> get selectedSurahAyahsFileNames {
    final selectedSurah = quranCtrl.state.surahs[currentSurahNumInPage - 1];
    log('selectedSurah: ${selectedSurah.arabicName}',
        name: 'AudioController_selectedSurahAyahsFileNames');
    return List.generate(
        selectedSurah.ayahs.length,
        (i) => ayahReaderInfo[state.readerIndex.value]['url'] ==
                UrlConstants.ayahs1stSource
            ? '$reader/${selectedSurah.ayahs[i].ayahUQNumber}.mp3'
            : '$reader/${selectedSurah.surahNumber.toString().padLeft(3, "0")}${selectedSurah.ayahs[i].ayahNumber.toString().padLeft(3, "0")}.mp3');
  }

  // +1
  List<String> get selectedSurahAyahsUrls {
    return List.generate(selectedSurahAyahsFileNames.length,
        (i) => '$ayahDownloadSource${selectedSurahAyahsFileNames[i]}');
  }

  String get ayahDownloadSource =>
      ayahReaderInfo[state.readerIndex.value]['url'] ==
              UrlConstants.ayahs1stSource
          ? UrlConstants.ayahs1stSource
          : UrlConstants.ayahs2ndSource;

  String get currentAyahUrl => '$ayahDownloadSource$currentAyahFileName';

  void get pausePlayer async {
    state.isPlay.value = false;
    await state.audioPlayer.pause();
  }
}
