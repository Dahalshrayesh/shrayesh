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

import 'package:audio_service/audio_service.dart';
import 'package:Shrayesh_music/CustomWidgets/bouncy_sliver_scroll_view.dart';
import 'package:Shrayesh_music/CustomWidgets/empty_screen.dart';
import 'package:Shrayesh_music/CustomWidgets/gradient_containers.dart';
import 'package:Shrayesh_music/Screens/Player/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../CustomWidgets/miniplayer.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
      Expanded(
      child: StreamBuilder<PlaybackState>(
        stream: audioHandler.playbackState,
        builder: (context, snapshot) {
          final playbackState = snapshot.data;
          final processingState = playbackState?.processingState;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: processingState != AudioProcessingState.idle
                ? null
                : AppBar(
              title: Text(AppLocalizations.of(context)!.nowPlaying),
              centerTitle: true,
              backgroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.secondary,
              elevation: 0,
                  ),
            body: processingState == AudioProcessingState.idle
                ? emptyScreen(
                    context,
                    3,
                    AppLocalizations.of(context)!.nothingIs,
                    18.0,
                    AppLocalizations.of(context)!.playingCap,
                    30,
                    AppLocalizations.of(context)!.playSomething,
                    23.0,
                  )
                : StreamBuilder<MediaItem?>(
                    stream: audioHandler.mediaItem,
                    builder: (context, snapshot) {
                      final mediaItem = snapshot.data;
                      return mediaItem == null
                          ? const SizedBox()
                          : BouncyImageSliverScrollView(
                              scrollController: _scrollController,
                              title: AppLocalizations.of(context)!.nowPlaying,
                              localImage: mediaItem.artUri!
                                  .toString()
                                  .startsWith('file:'),
                              imageUrl: mediaItem.artUri!
                                      .toString()
                                      .startsWith('file:')
                                  ? mediaItem.artUri!.toFilePath()
                                  : mediaItem.artUri!.toString(),
                              sliverList: SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    NowPlayingStream(
                                      audioHandler: audioHandler,
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
          );
        },
      ),
      ),
          MiniPlayer(),
        ],
      )
    );
  }
}
