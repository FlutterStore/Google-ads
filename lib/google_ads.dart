import 'package:flutter/material.dart';
import 'package:google_ads/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admanger {
  AppOpenAd? appOpenAd;
  InterstitialAd? interstitialAd;
  RewardedAd? _rewardedAd;
  BannerAd? bannerAd;

  static initialize() {
    // ignore: unnecessary_null_comparison
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  BannerAd getBannerAd()
    {
      bannerAd = BannerAd(
        size: AdSize.banner, 
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(
          onAdClosed: (Ad ad){},
          onAdFailedToLoad: (Ad ad,LoadAdError error)
          {
            ad.dispose();
          },
          onAdLoaded: (Ad ad){},
          onAdOpened: (Ad ad){}
      ), 
      request: const AdRequest()
      );
      return bannerAd!;
    }

   showInterad() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;
        interstitialAd!.show();
      }, onAdFailedToLoad: (LoadAdError error) {
        showInterad();
      }),
    );
  }

  static startpageopenapp() async{
    await AppOpenAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/3419835294',
        request: const AdRequest(),
        orientation: AppOpenAd.orientationPortrait,
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (AppOpenAd ad){
              ad.show();
            },
            onAdFailedToLoad: (LoadAdError error){
              print("object");
              // startpageopenapp();
            }),
    );
  }

  createRewardedAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedads.value = 1;
            _rewardedAd = ad;
            ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
             });
          },
          onAdFailedToLoad: (LoadAdError error) {
            createRewardedAd();
          },
        ));   
  }
}

bannerAD()=>SizedBox(height:  60, child: AdWidget(ad: admanger.getBannerAd()..load(),key: UniqueKey(),) );

Admanger admanger = Admanger();