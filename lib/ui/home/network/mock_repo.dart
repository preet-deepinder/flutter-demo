import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flyy_test_task/constants/constants.dart';
import 'package:flyy_test_task/network/client/network_client.dart';
import 'package:flyy_test_task/ui/home/network/model/home_model.dart';
import 'package:flyy_test_task/ui/home/network/model/search_model.dart';

class MockRepo {
  Future<HomeResModel> localDatabase() async {
    try {
      final String response = await rootBundle.loadString('assets/fake_db/home.json');
      return HomeResModel.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SearchResModel> networkCall() async {
    try {
      final response = await NetworkClient.getInstance().get(
        AppConstant.search,
        queryParameters: {'q': 'car'},
      );

      if (response.statusCode == HttpStatus.ok) {
        return SearchResModel.fromJson(response.data);
      } else {
        throw response.data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
