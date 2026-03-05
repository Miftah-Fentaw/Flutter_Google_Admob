import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ads/ad_helper.dart';

class SimpleScreen extends StatefulWidget {
  final String title;

  const SimpleScreen({super.key, required this.title});

  @override
  State<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  RewardedInterstitialAd? _rewardedInterstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.title.toLowerCase() == 'search') {
      _loadRewardedInterstitialAd();
    }
  }

  void _loadRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdHelper.rewardedInterstitialAdUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('RewardedInterstitialAd loaded.');
          setState(() {
            _rewardedInterstitialAd = ad;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedInterstitialAd failed to load: $error');
          _rewardedInterstitialAd = null;
          _isAdLoaded = false;
        },
      ),
    );
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) return;

    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) =>
              debugPrint('$ad onAdShowedFullScreenContent'),
          onAdDismissedFullScreenContent: (ad) {
            debugPrint('$ad onAdDismissedFullScreenContent');
            ad.dispose();
            setState(() {
              _rewardedInterstitialAd = null;
              _isAdLoaded = false;
            });
            _loadRewardedInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            setState(() {
              _rewardedInterstitialAd = null;
              _isAdLoaded = false;
            });
            _loadRewardedInterstitialAd();
          },
        );

    _rewardedInterstitialAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint('User earned reward: ${reward.amount} ${reward.type}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reward Earned: ${reward.amount} ${reward.type}'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _rewardedInterstitialAd?.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    switch (widget.title.toLowerCase()) {
      case 'home':
        return Icons.home_rounded;
      case 'music':
        return Icons.music_note_rounded;
      case 'search':
        return Icons.search_rounded;
      case 'favorites':
        return Icons.favorite_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSearch = widget.title.toLowerCase() == 'search';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withAlpha(128),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIcon(), size: 80, color: colorScheme.primary),
          ),
          const SizedBox(height: 24),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome to the ${widget.title} page',
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          if (isSearch) ...[
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _isAdLoaded ? _showRewardedInterstitialAd : null,
              icon: Icon(
                _isAdLoaded ? Icons.play_circle_fill : Icons.hourglass_empty,
              ),
              label: Text(
                _isAdLoaded ? 'Show Rewarded Interstitial' : 'Loading Ad...',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: _isAdLoaded
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                foregroundColor: _isAdLoaded
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
