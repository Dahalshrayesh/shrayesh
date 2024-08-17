/*
 *  This file is part of Shrayesh-Music (https://bhupendra12345678.github.io/mymusic/).
 * 
 * Shrayesh-Music is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Shrayesh_music is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Shrayesh_music.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2023-2024, Bhupendra Dahal
 */


import 'package:Shrayesh_music/Screens/Home/home.dart';
import 'package:Shrayesh_music/Screens/Library/downloads.dart';
import 'package:Shrayesh_music/Screens/Library/nowplaying.dart';
import 'package:Shrayesh_music/Screens/Library/playlists.dart';
import 'package:Shrayesh_music/Screens/Library/recent.dart';
import 'package:Shrayesh_music/Screens/Library/stats.dart';
import 'package:Shrayesh_music/Screens/Login/auth.dart';
import 'package:Shrayesh_music/Screens/Login/pref.dart';
import 'package:Shrayesh_music/Screens/Settings/new_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Widget initialFuntion() {
  return Hive.box('settings').get('userId') != null ? HomePage() : AuthScreen();
}

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/': (context) => initialFuntion(),
  '/pref': (context) => const PrefScreen(),
  '/setting': (context) => const NewSettingsPage(),
  '/playlists': (context) => PlaylistScreen(),
  '/nowplaying': (context) => NowPlaying(),
  '/recent': (context) => RecentlyPlayed(),
  '/downloads': (context) => const Downloads(),
  '/stats': (context) => const Stats(),
};
