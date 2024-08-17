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

// import 'dart:io';

// import 'package:Shrayesh-Music/APIs/api.dart';
// import 'package:http/http.dart';

// Future<void> getArtistImage({
//   required String name,
//   required String tempDirPath,
// }) async {
//   if (tempDirPath == '') return;
//   final imageFile = File('$tempDirPath/images/artists/$name.jpg');
//   if (!await imageFile.exists()) {
//     final result = await SaavnAPI().fetchAlbums(
//       searchQuery: name,
//       type: 'artist',
//       count: 1,
//     );
//     if (result.isNotEmpty && result[0]['title'].toString() == name) {
//       final Uri url = Uri.parse(result[0]['image'].toString());
//       final response = await get(url);
//       await imageFile.create(recursive: true);
//       imageFile.writeAsBytesSync(response.bodyBytes);
//     }
//   }
// }