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




import 'package:Shrayesh_music/Screens/Home/saavn.dart';
import 'package:flutter/material.dart';
import '../../CustomWidgets/miniplayer.dart';



class SavnScreen extends StatefulWidget {
  const SavnScreen({
    super.key,
  });

  @override
  State<SavnScreen> createState() => _SavnScreenState();
}

class _SavnScreenState extends State<SavnScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  headerSliverBuilder: (
                      BuildContext context,
                      bool innerBoxScrolled,
                      ) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 0,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // pinned: true,
                        toolbarHeight: 0,
                        // floating: true,
                        automaticallyImplyLeading: false,
                        flexibleSpace: LayoutBuilder(
                          builder: (
                              BuildContext context,
                              BoxConstraints constraints,
                              ) {
                            return FlexibleSpaceBar(
                              titlePadding: EdgeInsets.zero,
                              // collapseMode: CollapseMode.parallax,
                                  );
                                  // setState(() {});
                                },
                              ),
                             ),
                          ];
                        },
                  body: SaavnHomePage(),
                ),
              ],
            ),
          ),
          MiniPlayer()
        ],
      ),
    );
  }
}
