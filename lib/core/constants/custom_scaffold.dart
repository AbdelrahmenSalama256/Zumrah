import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String? backgroundImagePath;
  final bool? hasBg;

  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundImagePath,
    this.hasBg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Positioned.fill(child: body),
        ],
      ),
    );
  }
}
