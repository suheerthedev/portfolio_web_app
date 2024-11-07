import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  final ScrollController scrollController = ScrollController();

  void scrollToSection(double offset) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
