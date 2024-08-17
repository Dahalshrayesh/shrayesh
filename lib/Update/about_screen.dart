import 'package:Shrayesh_music/Update/scaffold.dart';
import 'package:Shrayesh_music/Update/text_styles.dart';
import 'package:Shrayesh_music/Update/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_config.dart';

import 'check_update.dart';
import 'color_icon.dart';
import 'icons.dart';
import 'listtile.dart';



class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                      ],
                    ),
                    const SizedBox(height: 16),
                    AdaptiveListTile(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      leading: const ColorIcon(icon: Icons.other_houses, color: Colors.redAccent),
                      title: Text(
                        "Shrayesh Music",
                        style: textStyle(context, bold: false)
                            .copyWith(fontSize: 16),
                      ),
                      trailing: Text(
                        "Music",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    AdaptiveListTile(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      leading: const ColorIcon(
                          color: Colors.blueAccent, icon: Icons.new_releases),
                      title: Text(
                        "Version",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      trailing: Text(
                        appConfig.codeName,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                    AdaptiveListTile(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      leading: const ColorIcon(
                          color: Colors.greenAccent, icon: CupertinoIcons.person),
                      title: Text(
                        "Developer",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),


                      trailing: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "Bhupendra Dahal",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(AdaptiveIcons.chevron_right)
                        ],
                      ),
                      onTap: () => launchUrl(
                          Uri.parse('https://github.com/shrayesh1234'),
                          mode: LaunchMode.externalApplication),
                    ),


                    AdaptiveListTile(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      leading: const ColorIcon(color: Colors.deepOrangeAccent, icon: Icons.code),
                      title: Text(
                        "Source Code",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      trailing: Icon(AdaptiveIcons.chevron_right),
                      onTap: () => launchUrl(
                          Uri.parse('https://github.com/Dahalshrayesh/shrayesh'),
                          mode: LaunchMode.externalApplication),
                    ),
                    AdaptiveListTile(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      leading:
                      const ColorIcon(color: Colors.cyan, icon: Icons.bug_report),
                      title: Text(
                        "Bug Report",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      trailing: Icon(AdaptiveIcons.chevron_right),
                      onTap: () => launchUrl(
                          Uri.parse(
                              'https://github.com/Dahalshrayesh/shrayesh/issues/new?assignees=&labels=bug&projects=&template=bug_report.yaml'),
                          mode: LaunchMode.externalApplication),
                    ),
                    AdaptiveListTile(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      leading: const ColorIcon(
                          color: Colors.deepOrangeAccent, icon: Icons.request_page),
                      title: Text(
                        "Feature Request",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      trailing: Icon(AdaptiveIcons.chevron_right),
                      onTap: () => launchUrl(
                          Uri.parse(
                              'https://github.com/Dahalshrayesh/shrayesh/issues/new?assignees=sheikhhaziq&labels=enhancement%2CFeature+Request&projects=&template=feature_request.yaml'),
                          mode: LaunchMode.externalApplication),
                    ),
                    AdaptiveListTile(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        leading: const ColorIcon(
                            color: Colors.green, icon: Icons.update_outlined),
                        title: Text(
                          "Software Update",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        trailing: Icon(AdaptiveIcons.chevron_right),
                        onTap: () {
                          Update.showCenterLoadingModal(context);
                          checkUpdate().then((updateInfo) {
                            Navigator.pop(context);
                            Update.showUpdateDialog(context, updateInfo);
                          },
                          );
                        }

                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
