import 'package:download_animation/download_button.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            DownloadButton(buttonColor: CupertinoColors.systemPink),
            SizedBox(
              height: 20,
            ),
            DownloadButton(buttonColor: CupertinoColors.activeOrange),
            SizedBox(
              height: 20,
            ),
            DownloadButton(buttonColor: CupertinoColors.systemIndigo),
            SizedBox(
              height: 20,
            ),
            DownloadButton(buttonColor: CupertinoColors.destructiveRed),
            SizedBox(
              height: 20,
            ),
            DownloadButton(buttonColor: CupertinoColors.systemTeal),
          ],
        ),
      ),
    );
  }
}
