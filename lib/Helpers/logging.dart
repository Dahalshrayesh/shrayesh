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

import 'dart:developer';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initializeLogging() async {
  final Directory tempDir = await getTemporaryDirectory();
  final File logFile = File('${tempDir.path}/logs/logs.txt');
  if (!await logFile.exists()) {
    await logFile.create(recursive: true);
  }
  // clear old session data
  await logFile.writeAsString('');
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) async {
    if (record.level.name != 'INFO') {
      log('${record.level.name}: ${record.time}: record.message: ${record.message}\nrecord.error: ${record.error}\nrecord.stackTrace: ${record.stackTrace}\n\n');
      try {
        await logFile.writeAsString(
          '${record.level.name}: ${record.time}: record.message: ${record.message}\nrecord.error: ${record.error}\nrecord.stackTrace: ${record.stackTrace}\n\n',
          mode: FileMode.append,
        );
      } catch (e) {
        log('Error writing to log file: $e');
      }
    } else {
      log('${record.level.name}: ${record.time}: record.message: ${record.message}\n\n');
      try {
        await logFile.writeAsString(
          '${record.level.name}: ${record.time}: record.message: ${record.message}\n\n',
          mode: FileMode.append,
        );
      } catch (e) {
        log('Error writing to log file: $e');
      }
    }
  });
}