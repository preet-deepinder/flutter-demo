import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyy_test_task/constants/constants.dart';
import 'package:flyy_test_task/network/network_exception.dart';
import 'package:flyy_test_task/ui/home/network/mock_repo.dart';
import 'package:flyy_test_task/ui/home/network/model/home_model.dart';
import 'package:flyy_test_task/ui/home/network/model/search_model.dart';

final homeProvider = ChangeNotifierProvider.autoDispose<HomeNotifier>(
  (ref) => HomeNotifier(),
);

class HomeNotifier extends ChangeNotifier {
  final MockRepo _mockRepo = MockRepo();
  final PageController _viewpageController = PageController();

  String? _failure, _exception;
  HomeResModel? _mockData;
  SearchResModel? _photoData;

  String? get failure => _failure;
  String? get exception => _exception;
  HomeResModel? get localData => _mockData;
  SearchResModel? get networkData => _photoData;
  PageController get viewpageController => _viewpageController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void showLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoader() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchData() async {
    _failure = null;
    showLoader();
    await getLocalData();
    await getNetworkData();
    hideLoader();
  }

  Future<void> getLocalData() async {
    _mockData = await _mockRepo.localDatabase();
  }

  Future<void> getNetworkData() async {
    try {
      _photoData = await _mockRepo.networkCall();
    } on Failure catch (f) {
      _failure = f.msg;
      hideLoader();
    } catch (e) {
      _exception = e.toString();
      hideLoader();
    }
  }

  void onNext() {
    _viewpageController.nextPage(
      duration: const Duration(milliseconds: AppConstant.defaultAnimationDuration),
      curve: Curves.ease,
    );
  }

  void onPrev() {
    _viewpageController.previousPage(
      duration: const Duration(milliseconds: AppConstant.defaultAnimationDuration),
      curve: Curves.ease,
    );
  }
}
