import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:chowwe_rider/cores/constants/color.dart';
import 'package:chowwe_rider/features/food/UI/pages/home_page.dart';
import 'package:chowwe_rider/features/food/UI/pages/notification_screen.dart';
import 'package:chowwe_rider/features/food/UI/pages/wallet_page.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({Key? key}) : super(key: key);
  static final ValueNotifier<int> _pageIndex = ValueNotifier<int>(1);
  static const List<Widget> _pages = <Widget>[
    WalletScreen(),
    HomePage(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _pageIndex,
        builder: (BuildContext context, int index, Widget? child) {
          return IndexedStack(
            index: index,
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 350),
        buttonBackgroundColor: kcPrimaryColor.withOpacity(0.7),
        items: <Widget>[
          Icon(Icons.account_balance_wallet_rounded,
              size: 25, color: Colors.grey[600]),
          Icon(Icons.home_filled, size: 25, color: Colors.grey[600]),
          Icon(Icons.notifications, size: 25, color: Colors.grey[600]),
        ],
        onTap: (int index) => _pageIndex.value = index,
      ),
    );
  }
}
