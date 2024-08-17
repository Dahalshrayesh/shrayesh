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

import 'package:Shrayesh_music/CustomWidgets/box_switch_tile.dart';
import 'package:Shrayesh_music/CustomWidgets/gradient_containers.dart';

import 'package:Shrayesh_music/Helpers/backup_restore.dart';
import 'package:Shrayesh_music/Helpers/config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

class PrefScreen extends StatefulWidget {
  const PrefScreen({super.key});

  @override
  _PrefScreenState createState() => _PrefScreenState();
}

class _PrefScreenState extends State<PrefScreen> {
  List<String> languages = [
    'Nepali',
    'English',
    
  ];
  List<bool> isSelected = [true, false];
  List preferredLanguage = Hive.box('settings')
      .get('preferredLanguage', defaultValue: [''])?.toList() as List;
  String region =
      Hive.box('settings').get('region', defaultValue: 'India') as String;
  bool useProxy =
      Hive.box('settings').get('useProxy', defaultValue: false) as bool;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.sizeOf(context).width / 1.85,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width,
                  child: const Image(
                    image: AssetImage(
                      'assets/icon-white-trans.png',
                    ),
                  ),
                ),
              ),
              const GradientContainer(
                child: null,
                opacity: true,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await restore(context);
                          GetIt.I<MyTheme>().refresh();
                          Navigator.popAndPushNamed(context, '/');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.restore,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.popAndPushNamed(context, '/');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.skip,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.welcome}\n',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    height: 1.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          AppLocalizations.of(context)!.aboard,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' - Music\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          AppLocalizations.of(context)!.prefReq,
                                      style: TextStyle(
                                        height: 1.5,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [

                                  const SizedBox(
                                    height: 20.0,
                                  ),


                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Visibility(
                                    visible: region != 'Nepali',
                                    child: BoxSwitchTile(
                                      title: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .useProxy,
                                      ),
                                      keyName: 'useProxy',
                                      defaultValue: false,
                                      contentPadding: EdgeInsets.zero,
                                      onChanged: ({
                                        required bool val,
                                        required Box box,
                                      }) {
                                        useProxy = val;
                                        setState(
                                          () {},
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.popAndPushNamed(
                                        context,
                                        '/',
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      height: 35.0,
                                      width: 80,

                                        decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.black,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5.0,
                                            offset: Offset(0.0, 3.0),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.finish,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
