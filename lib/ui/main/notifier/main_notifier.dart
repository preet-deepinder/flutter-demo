import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider = ChangeNotifierProvider.autoDispose<MainNotifier>(
  (ref) => MainNotifier(),
);

class MainNotifier extends ChangeNotifier {
  final MethodChannel _methodChannel = const MethodChannel('FLUTTER_CHANNEL');

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Uint8List? _image;
  Uint8List? get image => _image;

  Future<void> onCamera() async {
    try {
      final result = await _methodChannel.invokeMethod('OPEN_CAMERA');
      _image = result;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onNavigation(int i) {
    _currentIndex = i;
    notifyListeners();
  }
}
