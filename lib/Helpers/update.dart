/*
 *  This file is part of Shrayesh-Music (https://bhupendra12345678.github.io/mymusic/).
 * 
 * Shrayesh-Music is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Shrayesh-Music is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Shrayesh-Music.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2023-2024, Bhupendra Dahal
 */

import 'package:logging/logging.dart';

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
      Logger.root.severe('Error while comparing versions: $e');
      break;
    }
  }
  return update;
}
