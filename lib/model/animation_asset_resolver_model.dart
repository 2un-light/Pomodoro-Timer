class AnimationAssetResolver {
  static String getVideoPath({
    required String themeName,
    required String sessionType,

  }){
    final pathPrefix = 'assets/videos';
    final theme = ['white', 'dark'].contains(themeName) ? themeName : 'cream';
    return '$pathPrefix/${sessionType}_time_$theme.mp4';
  }
}