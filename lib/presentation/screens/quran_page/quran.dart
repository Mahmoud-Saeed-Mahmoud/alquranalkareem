import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;
import 'dart:developer';
import 'dart:io' show Directory, File;
import 'dart:math' as math;

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animations/animations.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audio_service/audio_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show
        Clipboard,
        ClipboardData,
        LogicalKeyboardKey,
        PlatformException,
        Uint8List,
        rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' as intl;
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:read_more_less/read_more_less.dart';
import 'package:rxdart/rxdart.dart' as R;
import 'package:screenshot/screenshot.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';

import '/core/utils/constants/extensions/alignment_rotated_extension.dart';
import '/core/utils/constants/extensions/bottom_sheet_extension.dart';
import '/core/utils/constants/extensions/convert_number_extension.dart';
import '/core/utils/constants/extensions/custom_error_snackBar.dart';
import '/core/utils/constants/extensions/custom_mobile_notes_snack_bar.dart';
import '/core/utils/constants/extensions/extensions.dart';
import '/core/utils/constants/extensions/font_size_extension.dart';
import '/core/utils/constants/extensions/menu_extension.dart';
import '/core/utils/constants/extensions/svg_extensions.dart';
import '/core/utils/constants/extensions/text_span_extension.dart';
import '/presentation/controllers/general/extensions/general_getters.dart';
import '/presentation/controllers/general/extensions/general_ui.dart';
import '/presentation/controllers/general/general_controller.dart';
import '/presentation/screens/quran_page/widgets/search/search_extensions/highlight_extension.dart';
import '../../../../../../core/utils/constants/lists.dart';
import '../../../../../../core/utils/constants/url_constants.dart';
import '../../../../../../core/widgets/seek_bar.dart';
import '../../../core/services/notifications_manager.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/lottie.dart';
import '../../../core/utils/constants/lottie_constants.dart';
import '../../../core/utils/constants/shared_preferences_constants.dart';
import '../../../core/utils/constants/svg_constants.dart';
import '../../../core/utils/helpers/global_key_manager.dart';
import '../../../core/utils/helpers/responsive.dart';
import '../../../core/widgets/delete_widget.dart';
import '../../../core/widgets/elevated_button_widget.dart';
import '../../../core/widgets/measure_size_widget.dart';
import '../../../core/widgets/share/share_ayah_options.dart';
import '../../../core/widgets/tab_bar_widget.dart';
import '../../../database/bookmark_db/bookmark_database.dart';
import '../../../database/bookmark_db/db_bookmark_helper.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';
import 'data/data_source/quran_database.dart';
import 'data/data_source/tafsir_database.dart';
import 'data/model/surahs_model.dart';
import 'data/model/tafsir.dart';
import 'widgets/khatmah/data/data_source/khatmah_database.dart';
import 'widgets/playlist/data/models/playList_model.dart';
import 'widgets/search/controller/quran_search_controller.dart';

part 'controllers/audio/audio_controller.dart';
part 'controllers/audio/audio_state.dart';
part 'controllers/bookmarks_controller.dart';
part 'controllers/extensions/audio/audio_getters.dart';
part 'controllers/extensions/audio/audio_storage_getters.dart';
part 'controllers/extensions/audio/audio_ui.dart';
part 'controllers/extensions/quran/quran_getters.dart';
part 'controllers/extensions/quran/quran_ui.dart';
part 'controllers/extensions/tafsir/tafsir_ui.dart';
part 'controllers/khatmah_controller.dart';
part 'controllers/playList_controller.dart';
part 'controllers/quran/quran_controller.dart';
part 'controllers/quran/quran_state.dart';
part 'controllers/share_controller.dart';
part 'controllers/tafsir_ctrl.dart';
part 'controllers/translate_controller.dart';
part 'extensions/bookmark_page_icon_path.dart';
part 'extensions/sajda_extension.dart';
part 'extensions/surah_info_extension.dart';
part 'extensions/surah_name_with_banner.dart';
part 'screens/quran_home.dart';
part 'screens/quran_page.dart';
part 'widgets/audio/audio_widget.dart';
part 'widgets/audio/change_reader.dart';
part 'widgets/audio/play_ayah_widget.dart';
part 'widgets/audio/skip_next.dart';
part 'widgets/audio/skip_previous.dart';
part 'widgets/ayahs/ayah_build.dart';
part 'widgets/ayahs/ayahs_menu.dart';
part 'widgets/ayahs/ayahs_widget.dart';
part 'widgets/ayahs/change_translate.dart';
part 'widgets/ayahs/share_copy_widget.dart';
part 'widgets/ayahs/translate_build.dart';
part 'widgets/bookmarks/bookmark_ayahs_build.dart';
part 'widgets/bookmarks/bookmark_pages_build.dart';
part 'widgets/bookmarks/bookmarks_list.dart';
part 'widgets/bookmarks/khatmah_bookmarks_screen.dart';
part 'widgets/buttons/add_bookmark_button.dart';
part 'widgets/buttons/copy_button.dart';
part 'widgets/buttons/play_button.dart';
part 'widgets/buttons/tafsir_button.dart';
part 'widgets/change_tafsir.dart';
part 'widgets/juz_page.dart';
part 'widgets/khatmah/screen/khatmahs_screen.dart';
part 'widgets/khatmah/widgets/add_khatmah_widget.dart';
part 'widgets/khatmah/widgets/khatmah_build_widget.dart';
part 'widgets/khatmah/widgets/khatmah_days_page.dart';
part 'widgets/khatmah/widgets/khatmah_name_widget.dart';
part 'widgets/pages/custom_span.dart';
part 'widgets/pages/left_page.dart';
part 'widgets/pages/nav_bar_widget.dart';
part 'widgets/pages/pages_widget.dart';
part 'widgets/pages/right_page.dart';
part 'widgets/pages/text_build.dart';
part 'widgets/pages/text_scale_build.dart';
part 'widgets/pages/top_title_widget.dart';
part 'widgets/playlist/ayahs_choice_widget.dart';
part 'widgets/playlist/ayahs_playList_widget.dart';
part 'widgets/playlist/playList_ayat_widget.dart';
part 'widgets/playlist/playList_build.dart';
part 'widgets/playlist/playList_play_button.dart';
part 'widgets/playlist/playList_play_widget.dart';
part 'widgets/playlist/playList_save_widget.dart';
part 'widgets/quran_surah_list.dart';
part 'widgets/screen_switch.dart';
part 'widgets/search/last_search_widget.dart';
part 'widgets/search/quran_search.dart';
part 'widgets/search/search_bar.dart';
part 'widgets/search/search_bar_widget.dart';
part 'widgets/show_tafseer.dart';
part 'widgets/surah_juz_list.dart';
