import 'package:flutter/material.dart';

/// CONFIGS DATA
class MyConfig {
  /// APP CONFIG
  static final String VERSION = "0.0.2";
  static final String APP_NAME = "-- FLUTTER BASE APP --";
  // static final String BASE_URL = baseURL ?? "";
  static final String TOKEN_STRING_KEY = 'TOKEN_STRING_KEY';
  static final String ID_USER = 'ID_USER';
  static final String NAME_USER = 'NAME_USER';
  static final String EMAIL_KEY = 'EMAIL_KEY';
  static final String FCM_TOKEN_KEY = 'EMAIL_KEY';
  static final String ACCESS_TOKEN_KEY = '${VERSION}ACCESS_TOKEN_KEY';
  static final String REFRESH_TOKEN_KEY = '${VERSION}REFRESH_TOKEN_KEY';
  static final String API_KEY = '${VERSION}API_KEY';
  // static final String DEVICE_ID = '${VERSION}DEVICE_ID'
}

/// SPACINGS DATA
class MySpace {
  /// Padding
  static final double paddingZero = 0.0;
  static final double paddingXS = 2.0;
  static final double paddingS = 4.0;
  static final double paddingM = 8.0;
  static final double paddingL = 16.0;
  static final double paddingXL = 32.0;
  static final double paddingXXL = 36.0;

  /// Margin
  static final double marginZero = 0.0;
  static final double marginXS = 2.0;
  static final double marginS = 4.0;
  static final double marginM = 8.0;
  static final double marginL = 16.0;
  static final double marginXL = 32.0;

  /// Spacing
  static final double spaceXS = 2.0;
  static final double spaceS = 4.0;
  static final double spaceM = 8.0;
  static final double spaceL = 16.0;
  static final double spaceXL = 32.0;
}

/// COLORS DATA
class MyColor {
  MyColor._();

  /// Common Colors
  static final PRIMARY_100 = Color(0xFFFF4218);
  static final PRIMARY_3 = Color(0xFFF8F8ED);
  static final bgColor = Color(0xFFF7F7EB);
  static final Color LIGHT_BACKGROUND_COLOR = Color(0xFFF9F9F9);
  static final ACCENT_COLOR = Color(0xFF9B51E0);
  static final PRIMARY_VARIANT = Color(0xFF9B51E0);
  static final PRIMARY_VARIANT_LIGHT = Color(0xFFE8F5E9);
  static final PRIMARY_SWATCH = Color(0xFF3681EC);
  static final textDisable = Color(0xFF767676);
  static final primary5 = Color(0xFFFFEDE9);

  static final ICON_COLOR = Colors.white;

  static final PRIMARY_DARK_COLOR = Color(0xFF250048);
  static final Color DARK_BACKGROUND_COLOR = Color(0xFF000000);
  static final ICON_COLOR_DARK = Colors.white;
  static final TEXT_COLOR_DARK = Color(0xFFffffff);
  static final BUTTON_COLOR_DARK = PRIMARY_DARK_COLOR;
  static final TEXT_BUTTON_COLOR_DARK = Colors.black;

  static final primary = Color(0xFFAA8F00);
  static final primary_1 = Color(0xFFC8BF7F);
  static final primary_2 = Color(0xFFEDEDDC);
  static final text_3 = Color(0xFFD15278);
  static final darkgreen = Color(0xFF07454E);
  static final Deepgreen = Color(0xFF106D79);
  static final Purple = Color(0xFF9669BA);
  static final Gradient_2 = [
    Color(0xFFE5D6F3),
    Color(0xFFA797D4),
  ];
  static final Gradient_1 = [
    Color(0xFFFCE5DF),
    Color(0xFFF3BDC6),
  ];
  static final highlightYellow = Color(0xFFFEFFC3);
  static final success = Color(0xFF46CC94);
  static final errorFill = Color(0xFFFEF6F7);
  static final error = Color(0xFFFC2134);
  static final error_60 = Color(0xFFFF5449);
  static final titleBackground = Color(0xFFF3F3F3);
  static final background = Color(0xFFF6F6F6);
  static final border = Color(0xFFB9B9B9);
  static final disabled = Color(0xFFCCCCCC);
  static final placeholder = Color(0xFFBBBBBB);
  static final primary_50 = Color(0xFFB4E1E3);
  static final primary_60 = Color(0xFFAA8F00);
  static final primary_10 = Color(0xFFE8F4F6);
  static final primary_5 = Color(0xFFF6FBFB);
  static final tertiary = Color(0xFFFC6A96);
  static const secondary = Color(0xFF1B95A5);
  static final text_2 = Color(0xFF232363);
  static final text_1 = Color(0xFF2C2C2C);
  static final black_80 = Color(0xFF000000).withOpacity(0.8);
  static final text = Color(0xFF333333);
  static final black = Color(0xFF010101);
  static final white = Color(0xFFFFFFFF);
  static final lightGray = Color(0xFFF5F5F5);
  static final disable = Color(0xFFE7E7E7);
  static final onSurface = Color(0xFF171923);
  static final blackAlpha200 = Color(0xFF000000).withOpacity(0.08);
  static final M3SysLightPrimary = Color(0xFF695F00);
  static final M3SysLightInverseOnSurface = Color(0xFFF5F0E7);
  static final M3SysLightInverseSurface = Color(0xFF32302A);
  static final chartDarkGray = Color(0xFFE6E6E6);
  static final chartBorder = Color(0xFFC0C0C0);
  static final secondary94 = Color(0xFFFAEDC6);
  static final secondaryFixed = Color(0xFFEFE2BC);
  static final outlineVariant = Color(0xFFCDC6B4);
  static final lightBlue = Color(0xFFEBF6FF);
  static final lightSurface = Color(0xFFFFF9EF);
  static final lightPrimaryContainer = Color(0xFF221B00);

  /// Border
  static final outlineBorder = Color(0xFF718096);
  static final outlineButton = Color(0xFFB9B9B9);
  static final outlineStepItem = Color(0xFFFFAF36);

  ///Text
  static final surfaceVariant = Color(0xFF4A5568);
  static final textDisabled = Color(0xFF4A5568);
  static final redDark = Color(0xFFC53030);
  static final grey200 = Color(0xFFE2E8F0);

  ///Button
  static final bgButton = Color(0xFF3D3D3D);

  ///chart radar
  static final chartGreen = Color(0xFF37CB03);
  static final chartYellow = Color(0xFFFFE81B);
  static final chartRed = Color(0xFFFF2121);
  static final chartBlue = Color(0xFF007BD5);

  static final bgChatSender = Color(0xFFFFEDE9);
  static final bgChatReceipt = Color(0xFFF5F5F5);

  static final blue = Color(0xFF009CDE);
  static final yellow = Color(0xFFFFD600);
  static final grey = Color(0xFF525252);
}
