import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String? backgroundImagePath;
  final bool? hasBg;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final bool extendBody;

  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundImagePath,
    this.hasBg,
    this.drawer,
    this.scaffoldKey,
    this.appBar,
    this.extendBodyBehindAppBar = true,
    this.extendBody = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        extendBody: extendBody,
        body: Stack(
          children: [
            Positioned.fill(
              child: hasBg == false
                  ? Container()
                  : Image.asset(
                      "assets/images/png/main.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset("assets/images/svg/main.svg",
                            fit: BoxFit.cover);
                      },
                    ),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: body,
            )
          ],
        ),
      ),
    );
  }
}
