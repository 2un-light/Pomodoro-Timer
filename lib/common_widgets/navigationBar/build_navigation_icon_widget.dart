import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:provider/provider.dart';

class BuildNavIcon extends StatelessWidget {
  final String iconName;
  final double size;

   const BuildNavIcon({
    super.key,
    required this.iconName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final isDark = themeService.currentTheme.name == 'dark';
    final iconPath = isDark ? 'assets/icons/${iconName}_dark.svg' : 'assets/icons/${iconName}.svg';

    return SvgPicture.asset(
      iconPath,
      width: size,
      height: size,
      semanticsLabel: '$iconName icon',
    );
  }
}
