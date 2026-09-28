import 'package:flutter/material.dart';
import 'customer/home_screen.dart';
import 'customer/packages_subscriptions_screen.dart';
import 'partner/partner_duty_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          PackagesSubscriptionsScreen(),
          PartnerDutyScreen(),
        ],
      ),
    );
  }
}