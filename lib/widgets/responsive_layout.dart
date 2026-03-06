import 'package:flutter/material.dart';

/// Breakpoints: mobile < 600, tablet < 900, desktop >= 900.
/// Max content width for large screens.
const double kMobileBreakpoint = 600;
const double kTabletBreakpoint = 900;
const double kMaxContentWidth = 1200;

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.body,
  });

  final Widget body;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < kMobileBreakpoint;
  }

  static bool isTabletOrLarger(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= kMobileBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= kTabletBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
        child: body,
      ),
    );
  }
}
