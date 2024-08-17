/*
 *  This file is part of shrayesh (https://github.com/Sangwan5688/shrayesh).
 *
 * shrayesh is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * shrayesh is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with shrayesh.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright (c) 2021-2022, Wali Ullah Shuvo
 */


import 'dart:isolate';
import 'dart:math';

import 'package:Shrayesh_music/CustomWidgets/gradient_containers.dart';
import 'package:Shrayesh_music/CustomWidgets/snackbar.dart';
import 'package:Shrayesh_music/Helpers/downloads_checker.dart';
import 'package:Shrayesh_music/Screens/Home/saavnhome.dart';


import 'package:Shrayesh_music/Screens/Search/search.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../Update/check_update.dart';
import '../../Update/update.dart';
import '../Settings/new_settings_page.dart';
import 'download_home.dart';
import 'home_screen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  bool checked = false;
  String? appVersion;
  String name =
  Hive.box('settings').get('name', defaultValue: 'Guest') as String;
  bool autoBackup =
  Hive.box('settings').get('autoBackup', defaultValue: false) as bool;
  List sectionsToShow = Hive.box('settings').get(
    'sectionsToShow',
    defaultValue: ['Home', 'Top Charts', 'YouTube', 'Library'],
  ) as List;
  DateTime? backButtonPressTime;

  void callback() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    _pageController.jumpToPage(
      index,
    );
  }

  bool compareVersion(String latestVersion, String currentVersion) {
    bool update = false;
    final List latestList = latestVersion.split('.');
    final List currentList = currentVersion.split('.');

    for (int i = 0; i < latestList.length; i++) {
      try {
        if (int.parse(latestList[i] as String) >
            int.parse(currentList[i] as String)) {
          update = true;
          break;
        }
      } catch (e) {
        break;
      }
    }
    return update;
  }

  void updateUserDetails(String key, dynamic value) {

  }

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > const Duration(seconds: 3);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ShowSnackBar().showSnackBar(
        context,
        AppLocalizations.of(context)!.exitConfirm,
        duration: const Duration(seconds: 2),
        noAction: true,
      );
      return false;
    }
    return true;
  }

  Widget checkVersion() {
    if (!checked && Theme.of(context).platform == TargetPlatform.android) {
      checked = true;
      final DateTime now = DateTime.now();
      final List lastLogin = now
          .toUtc()
          .add(const Duration(hours: 5, minutes: 30))
          .toString()
          .split('.')
        ..removeLast()
        ..join('.');
      updateUserDetails('lastLogin', '${lastLogin[0]} IST');
      final String offset =
      now.timeZoneOffset.toString().replaceAll('.000000', '');

      updateUserDetails(
        'timeZone',
        'Zone: ${now.timeZoneName}, Offset: $offset',
      );

      if (autoBackup) {
      }
      if (Hive.box('settings').get('proxyIp') == null) {
        Hive.box('settings').put('proxyIp', '103.47.67.134');
      }
      if (Hive.box('settings').get('proxyPort') == null) {
        Hive.box('settings').put('proxyPort', 8080);
      }
      downloadChecker();
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  _update() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;
    UpdateInfo? updateInfo = await Isolate.run(() async {
      return await checkUpdate(deviceInfo: deviceInfo);
    });

    if (updateInfo != null) {
      if (mounted) {
        Update.showUpdateDialog(context, updateInfo);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return GradientContainer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: GradientContainer(
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  stretch: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                    title: RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.appTitle,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: appVersion == null ? '' : '\nv$appVersion',
                            style: const TextStyle(
                              fontSize: 7.0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.end,
                    ),
                    titlePadding: const EdgeInsets.only(bottom: 40.0),
                    centerTitle: true,
                    background: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.1),
                          ],
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                          Theme.of(context).brightness == Brightness.dark
                              ? 'assets/header-dark.jpg'
                              : 'assets/header.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 30, 5, 100),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.madeBy,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: Colors.teal),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: PopScope(
          child: SafeArea(
            child: Row(
              children: [
                if (rotated)
                  ValueListenableBuilder(
                    valueListenable: _selectedIndex,
                    builder:
                        (BuildContext context, int indexValue, Widget? child) {
                      return NavigationRail(
                        minWidth: 70.0,
                        groupAlignment: 0.0,
                        backgroundColor:
                        // Colors.transparent,
                        Theme.of(context).cardColor,
                        selectedIndex: indexValue,
                        onDestinationSelected: (int index) {
                          _onItemTapped(index);
                        },
                        labelType: screenWidth > 1050
                            ? NavigationRailLabelType.selected
                            : NavigationRailLabelType.none,
                        selectedLabelTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelTextStyle: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                        ),
                        selectedIconTheme: Theme.of(context).iconTheme.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        unselectedIconTheme: Theme.of(context).iconTheme,
                        useIndicator: screenWidth < 1050,
                        indicatorColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        leading: screenWidth > 1050
                            ? null
                            : Builder(
                          builder: (context) => Transform.rotate(
                            angle: 22 / 7 * 2,
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.bars,
                              ),
                              // color: Theme.of(context).iconTheme.color,
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              tooltip: MaterialLocalizations.of(context)
                                  .openAppDrawerTooltip,
                            ),
                          ),
                        ),

                        destinations: [
                          NavigationRailDestination(
                            icon: const Icon(Icons.home_rounded),
                            label: Text(AppLocalizations.of(context)!.home),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.trending_up_rounded),
                            label: Text(
                              AppLocalizations.of(context)!.topCharts,
                            ),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(MdiIcons.youtube),
                            label: Text(AppLocalizations.of(context)!.youTube),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.my_library_music_rounded),
                            label: Text(AppLocalizations.of(context)!.library),
                          ),
                        ],
                      );
                    },
                  ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (indx) {
                            _selectedIndex.value = indx;
                          },
                          controller: _pageController,
                          children: [
                            Stack(
                              children: [
                                checkVersion(),
                                NestedScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: _scrollController,
                                  headerSliverBuilder: (
                                      BuildContext context,
                                      bool innerBoxScrolled,
                                      ) {
                                    return <Widget>[
                                      SliverAppBar(
                                        automaticallyImplyLeading: false,
                                        pinned: true,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        stretch: true,
                                        toolbarHeight: 65,
                                        title: Align(
                                          alignment: Alignment.centerRight,
                                          child: AnimatedBuilder(
                                            animation: _scrollController,
                                            builder: (context, child) {
                                              return GestureDetector(
                                                child: AnimatedContainer(
                                                  width: (!_scrollController.hasClients ||
                                                      _scrollController.positions.length > 1)
                                                      ? MediaQuery.sizeOf(context).width
                                                      : min(
                                                    MediaQuery.sizeOf(context).width -
                                                        _scrollController.offset
                                                            .roundToDouble(),
                                                    MediaQuery.sizeOf(context).width -
                                                        (rotated ? 0 : 5),
                                                  ),
                                                  height: 40.0,
                                                  duration: const Duration(
                                                    milliseconds: 150,
                                                  ),
                                                  padding: const EdgeInsets.all(2.0),
                                                  // margin: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                      10.0,
                                                    ),
                                                    color: Theme.of(context).cardColor,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 5.0,
                                                        offset: Offset(1.5, 1.5),
                                                        // shadow direction: bottom right
                                                        // shadow direction: bottom right
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      Icon(
                                                        CupertinoIcons.search,
                                                        size: 30,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                                      const SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!
                                                            .searchText,
                                                        style: TextStyle(
                                                          fontSize: 22.0,
                                                          color:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .color,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const SearchPage(
                                                      query: '',
                                                      fromHome: true,
                                                      autofocus: true,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ];
                                  },

                                  body: const SavnScreen(),

                                ),
                              ],
                            ),
                            const HomeScreen(
                            ),

                            Downloadhome(),
                            NewSettingsPage(),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: rotated
            ? null
            : SafeArea(
          child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder:
                (BuildContext context, int indexValue, Widget? child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 1600),
                height: 60,
                child: SalomonBottomBar(
                  currentIndex: indexValue,
                  onTap: (index) {
                    _onItemTapped(index);
                  },
                  items: [
                    SalomonBottomBarItem(
                      activeIcon:
                      const Icon(CupertinoIcons.music_house_fill),
                      icon: const Icon(CupertinoIcons.home),
                      title: Text(AppLocalizations.of(context)!.home),
                      selectedColor:
                      Theme.of(context).colorScheme.secondary,
                    ),

                    SalomonBottomBarItem(
                      activeIcon:
                      const Icon(CupertinoIcons.music_note),
                      icon: const Icon(CupertinoIcons.music_note_list),
                      title: Text(AppLocalizations.of(context)!.songs),
                      selectedColor:
                      Theme.of(context).colorScheme.secondary,
                    ),

                    SalomonBottomBarItem(
                      activeIcon: const Icon(Icons.library_music),
                      icon: const Icon(Icons.library_music_outlined),
                      title: Text(AppLocalizations.of(context)!.library),
                      selectedColor:
                      Theme.of(context).colorScheme.secondary,
                    ),
                    SalomonBottomBarItem(
                      activeIcon:
                      const Icon(CupertinoIcons.settings),
                      icon: const Icon(Icons.settings_rounded),
                      title: Text(AppLocalizations.of(context)!.settings),
                      selectedColor:
                      Theme.of(context).colorScheme.secondary,
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
