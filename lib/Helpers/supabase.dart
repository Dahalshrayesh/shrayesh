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

import 'package:supabase/supabase.dart';

class SupaBase {
  final SupabaseClient client = SupabaseClient(
    'https://vuakihfddljlzovzbdaf.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNzU1MTk3MywiZXhwIjoxOTQzMTI3OTczfQ.4PzxpfIk81ZvLtUOe0muHVGiZLr-dMK7BLyFsUcrVtc',
  );
}
Future<void> updateUserDetails(
      String? userId,
      String key,
      dynamic value,
      ) async {
    // final response = await client.from('Users').update({key: value},
    //     returning: ReturningOption.minimal).match({'id': userId}).execute();
    // print(response.toJson());
  }







