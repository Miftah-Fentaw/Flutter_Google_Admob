import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'widgets/main_scaffold.dart';
import 'ads/app_open_ad_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set test device IDs BEFORE initialization for better reliability
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(testDeviceIds: ["C794431B2FCEC400A9AB38E5347EAEBF"]),
  );

  MobileAds.instance.initialize();
  runApp(const AdMobApp());
}

class AdMobApp extends StatefulWidget {
  const AdMobApp({super.key});

  @override
  State<AdMobApp> createState() => _AdMobAppState();
}

class _AdMobAppState extends State<AdMobApp> with WidgetsBindingObserver {
  late AppOpenAdManager _appOpenAdManager;

  @override
  void initState() {
    super.initState();
    _appOpenAdManager = AppOpenAdManager()..loadAd();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _appOpenAdManager.showAdIfAvailable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AdMob Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScaffold(),
    );
  }
}
