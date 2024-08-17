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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeDrawer({
  required BuildContext context,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  return Padding(
    padding: padding,
    child: Transform.rotate(
      angle: 22 / 7 * 2,
      child: IconButton(
        icon: const Icon(
          CupertinoIcons.bars,
        ),
        // color: Theme.of(context).iconTheme.color,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    ),
  );
}
