import 'dart:io';
import 'ad_config.dart';

class AdHelper {
  // SET THIS TO TRUE TO VERIFY UI WITH GOOGLE TEST ADS
  static const bool useTestAds = true;

  static String get bannerAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return Platform.isAndroid ? AdConfig.androidBannerId : AdConfig.iosBannerId;
  }

  static String get interstitialAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return Platform.isAndroid
        ? AdConfig.androidInterstitialId
        : AdConfig.iosInterstitialId;
  }

  static String get rewardedAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
    }
    return Platform.isAndroid
        ? AdConfig.androidRewardedId
        : AdConfig.iosRewardedId;
  }

  static String get nativeAdUnitId {
    if (useTestAds) {
      // Using Banner test ID because it's implemented as a BannerAd (Medium Rectangle) in VideosScreen
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return Platform.isAndroid ? AdConfig.androidNativeId : AdConfig.iosNativeId;
  }

  static String get appOpenAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9257395921'
          : 'ca-app-pub-3940256099942544/5575463023';
    }
    return Platform.isAndroid
        ? AdConfig.androidAppOpenId
        : AdConfig.iosAppOpenId;
  }

  static String get rewardedInterstitialAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5354046379'
          : 'ca-app-pub-3940256099942544/6978759866';
    }
    return Platform.isAndroid
        ? AdConfig.androidRewardedInterstitialId
        : AdConfig.iosRewardedInterstitialId;
  }
}
