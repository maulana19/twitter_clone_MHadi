import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/theme.dart';
import 'constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsConstants.twitterLogo,
          color: Colors.blue, colorBlendMode: BlendMode.srcIn),
      centerTitle: true,
    );
  }
}
