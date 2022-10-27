import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyy_test_task/constants/constants.dart';
import 'package:flyy_test_task/styles/dimensions.dart';
import 'package:flyy_test_task/styles/styles.dart';
import 'package:flyy_test_task/ui/home/network/model/search_model.dart';
import 'package:flyy_test_task/ui/home/notifier/home_notifier.dart';
import 'package:flyy_test_task/ui/main/notifier/main_notifier.dart';

import '../../styles/palette.dart';
import 'network/model/home_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    if (mounted) ref.read(homeProvider).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(mainProvider).image;

    const recommendedListHeight = 350.0;
    const capturedShotHeight = 300.0;
    const topDevsListHeight = 270.0;

    final watch = ref.watch(homeProvider);
    final read = ref.read(homeProvider);

    final List<RecommendedData>? recommendedData = watch.localData?.recommended;
    final List<TopDevlopersData>? topDevsData = watch.localData?.topDevlopers;
    final List<SearchData>? searchData = watch.networkData?.data;

    final failure = watch.failure;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (failure != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure)),
        );
      }
    });

    return RefreshIndicator(
      onRefresh: () => read.fetchData(),
      child: watch.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: topDevsListHeight,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: watch.viewpageController,
                        itemCount: searchData?.length ?? 0,
                        onPageChanged: (value) {},
                        itemBuilder: (context, index) {
                          final element = searchData?[index];

                          return Image.network(
                            element?.thumbs?.large ?? '',
                            height: double.maxFinite,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            color: AppColor.darkGrey,
                            elevation: 0,
                            height: 50,
                            onPressed: read.onPrev,
                            child: const Icon(Icons.navigate_before, color: AppColor.white),
                          ),
                          MaterialButton(
                            color: AppColor.darkGrey,
                            padding: EdgeInsets.zero,
                            height: 50,
                            elevation: 0,
                            onPressed: read.onNext,
                            child: const Icon(Icons.navigate_next, color: AppColor.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (image != null) const SizedBox(height: AppDimension.xxlPadding),
                if (image != null)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                    child: Text(
                      AppConstant.capturedShot,
                      style: AppStyle.titleXl,
                    ),
                  ),
                if (image != null) const SizedBox(height: AppDimension.defaultPadding),
                if (image != null)
                  Container(
                    height: capturedShotHeight,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimension.defaultPadding,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: AppStyle.defaultRadius,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(
                          image,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: AppColor.black.withOpacity(0.4),
                          ),
                        ),
                        Image.memory(
                          image,
                          fit: BoxFit.fitHeight,
                          height: double.maxFinite,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: AppDimension.xxlPadding),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                  child: Text(
                    AppConstant.recommended,
                    style: AppStyle.titleXl,
                  ),
                ),
                SizedBox(
                  height: recommendedListHeight,
                  child: ListView.separated(
                    itemCount: recommendedData?.length ?? 0,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding, vertical: AppDimension.defaultPadding),
                    separatorBuilder: (context, index) => const SizedBox(width: AppDimension.mediumPadding),
                    itemBuilder: (context, index) {
                      final element = recommendedData?[index];

                      return CupertinoButton(
                        onPressed: () {},
                        minSize: 0,
                        pressedOpacity: 0.8,
                        padding: EdgeInsets.zero,
                        child: AspectRatio(
                          aspectRatio: 10 / 12,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        element?.image ?? '',
                                        loadingBuilder: (context, child, loadingProgress) {
                                          return loadingProgress == null
                                              ? child
                                              : const Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                        },
                                        fit: BoxFit.cover,
                                        height: double.maxFinite,
                                        width: double.maxFinite,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: AppDimension.tinyPadding, horizontal: AppDimension.tinyPadding),
                                      margin: const EdgeInsets.symmetric(vertical: AppDimension.tinyPadding, horizontal: AppDimension.tinyPadding),
                                      decoration: BoxDecoration(
                                        color: AppColor.black,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.location_solid,
                                            color: AppColor.white,
                                            size: AppDimension.smallIconSize,
                                          ),
                                          const SizedBox(width: AppDimension.tinyPadding),
                                          Flexible(
                                            child: Text(element?.location ?? '', overflow: TextOverflow.ellipsis, softWrap: false, style: AppStyle.regularSmall),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      spreadRadius: -6,
                                      offset: const Offset(-10, 16),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(AppDimension.mediumPadding),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                element?.label ?? AppConstant.na,
                                                style: AppStyle.regularLarge,
                                              ),
                                              Text(
                                                AppConstant.buy,
                                                style: AppStyle.regular.apply(color: AppColor.black),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: AppDimension.xTinyPadding),
                                          Text(
                                            element?.rooms ?? AppConstant.na,
                                            style: AppStyle.regularLarge.apply(color: AppColor.black),
                                          ),
                                          const SizedBox(height: AppDimension.xTinyPadding),
                                          Text(
                                            element?.hotelName ?? AppConstant.na,
                                            style: AppStyle.regularLarge.apply(color: AppColor.darkGrey),
                                          ),
                                          const SizedBox(height: AppDimension.xTinyPadding),
                                          Text(
                                            '\$ ${element?.price ?? AppConstant.na}',
                                            style: AppStyle.regularLarge.apply(color: AppColor.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppDimension.largePadding),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                  child: Text(
                    AppConstant.topDevelopers,
                    style: AppStyle.titleXl,
                  ),
                ),
                SizedBox(
                  height: topDevsListHeight,
                  child: ListView.separated(
                    itemCount: topDevsData?.length ?? 0,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding, vertical: AppDimension.defaultPadding),
                    separatorBuilder: (context, index) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final element = topDevsData?[index];

                      return CupertinoButton(
                        onPressed: () {},
                        minSize: 0,
                        pressedOpacity: 0.8,
                        padding: EdgeInsets.zero,
                        child: AspectRatio(
                          aspectRatio: 10 / 11,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Image.network(
                                        element?.image ?? AppConstant.na,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          return loadingProgress == null ? child : const Center(child: CircularProgressIndicator());
                                        },
                                        fit: BoxFit.cover,
                                        height: double.maxFinite,
                                        width: double.maxFinite,
                                      ),
                                      ListView(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        children: [
                                          Text(
                                            element?.properties ?? AppConstant.na,
                                            style: AppStyle.regular.apply(color: AppColor.white),
                                          ),
                                          Text(
                                            AppConstant.properties,
                                            style: AppStyle.regular.apply(color: AppColor.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(color: AppColor.black.withOpacity(0.05), blurRadius: 4, spreadRadius: -6, offset: const Offset(-10, 16)),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimension.smallPadding,
                                        vertical: AppDimension.tinyPadding,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            element?.name ?? AppConstant.na,
                                            style: AppStyle.regularLarge.apply(color: AppColor.black),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            element?.yearEst ?? AppConstant.na,
                                            style: AppStyle.regular.apply(color: AppColor.darkGrey),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppDimension.largePadding),
              ],
            ),
    );
  }
}
