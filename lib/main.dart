
import 'dart:io' show Platform;
import 'package:final_3_admobes_banner_interstitial_rewarded/demo.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdRequest? adRequest;
  BannerAd? bannerAd;

  InterstitialAd? interstitialAd;

  RewardedAd? rewardedAd;

  @override
  void initState() {
    super.initState();

    String bannerId = Platform.isAndroid
        ? "ca-app-pub-3940256099942544/6300978111"
        : "ca-app-pub-3940256099942544/2934735716";

    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );

    BannerAdListener bannerAdListener = BannerAdListener(
      onAdClosed: (ad) {
        bannerAd!.load();
      },
      onAdFailedToLoad: (ad, error) {
        bannerAd!.load();
      },
    );
    bannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: bannerId,
      listener: bannerAdListener,
      request: adRequest!,
    );

    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdMob"),
      ),
      body: Column(
        children: [

          //Final Banner Ads Here And It is Complete

          SizedBox(
            child: AdWidget(ad: bannerAd!),
            height: 100,
          ),

          //Final Interstitial Ads Here And It is Complete

          ElevatedButton(
              onPressed: () {
                InterstitialAd.load(
                  adUnitId: Platform.isAndroid
                      ? "ca-app-pub-3940256099942544/1033173712"
                      : "ca-app-pub-3940256099942544/4411468910",
                  request: const AdRequest(),
                  adLoadCallback: InterstitialAdLoadCallback(
                    onAdLoaded: (ad) {
                      interstitialAd = ad;
                      ad.show();

                      interstitialAd?.fullScreenContentCallback =
                          FullScreenContentCallback(
                              onAdDismissedFullScreenContent: (ad) {
                                interstitialAd?.dispose();
                                ad.dispose();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Routespagehere()
                                  ),
                                );
                              }, onAdFailedToShowFullScreenContent: (ad, err) {
                            ad.dispose();
                            interstitialAd?.dispose();
                          });
                    },
                    onAdFailedToLoad: (err) {
                      interstitialAd?.dispose();
                    },
                  ),
                );
              },
              child: const Text("Show Interestital Ad")
          ),

          //Final Rewarded Ads Here And It is Complete

          ElevatedButton(
            onPressed: () {
              RewardedAd.load(
                adUnitId: Platform.isAndroid
                    ? "ca-app-pub-3940256099942544/5224354917"
                    : "ca-app-pub-3940256099942544/6978759866",
                request: const AdRequest(),
                rewardedAdLoadCallback: RewardedAdLoadCallback(
                  onAdLoaded: (ad) {
                    rewardedAd = ad;
                    rewardedAd?.show(
                      onUserEarnedReward: ((ad, reward) {
                        debugPrint("My Reward Amount -> ${reward.amount}");
                      }),
                    );

                    rewardedAd?.fullScreenContentCallback =
                        FullScreenContentCallback(
                            onAdFailedToShowFullScreenContent: (ad, err) {
                              ad.dispose();
                            }, onAdDismissedFullScreenContent: (ad) {
                          ad.dispose();
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return Routespagehere();
                          }));
                        });
                  },
                  onAdFailedToLoad: (err) {
                    debugPrint(err.message);
                  },
                ),
              );
            },
            child: const Text(
              "Load Reward Ad",
            ),
          ),
        ],
      ),
    );
  }
}

