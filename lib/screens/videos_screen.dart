import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ads/ad_helper.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  BannerAd? _nativePlaceholderAd;

  @override
  void initState() {
    super.initState();
    _nativePlaceholderAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() {}),
        onAdFailedToLoad: (ad, err) => ad.dispose(),
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativePlaceholderAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 3 && _nativePlaceholderAd != null) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text(
                  'Native Ad Placeholder (Medium Rectangle)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: _nativePlaceholderAd!.size.width.toDouble(),
                  height: _nativePlaceholderAd!.size.height.toDouble(),
                  child: AdWidget(ad: _nativePlaceholderAd!),
                ),
              ],
            ),
          );
        }
        return ListTile(
          leading: const Icon(Icons.play_circle),
          title: Text('Dummy Video Item ${index + 1}'),
          subtitle: const Text('Description of the dummy video content.'),
        );
      },
    );
  }
}
