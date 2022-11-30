import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ads/google_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

RxInt load = 0.obs;
RxInt ads = 0.obs;
RxInt rewardedads = 0.obs;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admanger.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  NativeAd? nativead;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ads.value = 1;
    });
    

    nativead = NativeAd(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110',
    factoryId: 'listTile',
    request: const AdRequest(),
    listener: NativeAdListener(
      onAdLoaded: (_) {
        load.value = 1;
      },
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
    );
    nativead!.load();

    super.initState();
  }

  openaapp()async{
    await admanger.startpageopenapp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar:  bannerAD(),
      appBar: AppBar(
        title: const Text('Google Ads'),
      ),
      body: Obx(()=>Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          load.value == 1 ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
              height: 110,
              alignment: Alignment.center,
              child: AdWidget(ad: nativead!),
              ),
            ) : const Text("data"),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
            onPressed: (){
              // admanger.showInterad();
           }, 
           child: Text("Interstitial Ads")
          ),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
            onPressed: ()async{
              // ads.value = 0;
              // await admanger.createRewardedAd();
           }, 
           child: Text("Rewarded Ads")
          ),
        ],
      ),
    ));
  }
}
