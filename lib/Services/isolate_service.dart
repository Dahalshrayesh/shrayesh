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
 * along with Shrayesh_music.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2023-2024, Bhupendra Dahal
 */

import 'dart:io';
import 'dart:isolate';

import 'package:Shrayesh_music/Screens/Player/audioplayer.dart';
import 'package:Shrayesh_music/Services/youtube_services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

SendPort? isolateSendPort;

Future<void> startBackgroundProcessing() async {
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  final receivePort = ReceivePort();
  await Isolate.spawn(_backgroundProcess, receivePort.sendPort);

  receivePort.listen((message) async {
    if (isolateSendPort == null) {
      Logger.root.info('setting isolateSendPort');
      isolateSendPort = message as SendPort;
      final appDocumentDirectoryPath =
          (await getApplicationDocumentsDirectory()).path;
      isolateSendPort?.send(appDocumentDirectoryPath);
    } else {
      await audioHandler.customAction('refreshLink', {'newData': message});
    }
  });
}

// The function that will run in the background Isolate
Future<void> _backgroundProcess(SendPort sendPort) async {
  final isolateReceivePort = ReceivePort();
  sendPort.send(isolateReceivePort.sendPort);
  bool hiveInit = false;

  await for (final message in isolateReceivePort) {
    if (!hiveInit) {
      String path = message.toString();
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        path += '/Shrayesh-Music/Database';
      } else if (Platform.isIOS) {
        path += '/Database';
      }
      Hive.init(path);
      await Hive.openBox('ytlinkcache');
      await Hive.openBox('settings');
      hiveInit = true;
      continue;
    }
    final newData =
        await YouTubeServices.instance.refreshLink(message.toString());
    sendPort.send(newData);
  }
}

void addIdToBackgroundProcessingIsolate(String id) {
  isolateSendPort?.send(id);
}
