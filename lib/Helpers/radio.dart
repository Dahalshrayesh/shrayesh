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

import 'package:Shrayesh_music/APIs/api.dart';
import 'package:Shrayesh_music/Services/player_service.dart';
import 'package:logging/logging.dart';

Future<void> createRadioItems({
  required List<String> stationNames,
  String stationType = 'entity',
  int count = 20,
}) async {
  Logger.root
      .info('Creating Radio Station of type $stationType with $stationNames');
  String stationId = '';
  final String? value = await SaavnAPI()
      .createRadio(names: stationNames, stationType: stationType);

  if (value == null) return;

  stationId = value;
  final List songsList = await SaavnAPI().getRadioSongs(
    stationId: stationId,
    count: count,
  );

  if (songsList.isEmpty) return;

  PlayerInvoke.init(
    songsList: songsList,
    index: 0,
    isOffline: false,
    shuffle: true,
  );
}
