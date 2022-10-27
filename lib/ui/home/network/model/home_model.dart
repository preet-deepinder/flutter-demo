class HomeResModel {
  List<RecommendedData>? recommended;
  List<TopDevlopersData>? topDevlopers;

  HomeResModel({this.recommended, this.topDevlopers});

  HomeResModel.fromJson(Map<String, dynamic> json) {
    if (json['recommended'] != null) {
      recommended = <RecommendedData>[];
      json['recommended'].forEach((v) {
        recommended!.add(RecommendedData.fromJson(v));
      });
    }
    if (json['top_devlopers'] != null) {
      topDevlopers = <TopDevlopersData>[];
      json['top_devlopers'].forEach((v) {
        topDevlopers!.add(TopDevlopersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recommended != null) {
      data['recommended'] = recommended!.map((v) => v.toJson()).toList();
    }
    if (topDevlopers != null) {
      data['top_devlopers'] = topDevlopers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendedData {
  String? hotelName;
  String? price;
  String? rooms;
  String? location;
  String? image;
  String? label;

  RecommendedData({this.hotelName, this.price, this.rooms, this.location, this.image, this.label});

  RecommendedData.fromJson(Map<String, dynamic> json) {
    hotelName = json['hotel_name'];
    price = json['price'];
    rooms = json['rooms'];
    location = json['location'];
    image = json['image'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_name'] = hotelName;
    data['price'] = price;
    data['rooms'] = rooms;
    data['location'] = location;
    data['image'] = image;
    data['label'] = label;
    return data;
  }
}

class TopDevlopersData {
  String? name;
  String? yearEst;
  String? properties;
  String? image;

  TopDevlopersData({this.name, this.yearEst, this.properties, this.image});

  TopDevlopersData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yearEst = json['year_est'];
    properties = json['properties'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['year_est'] = yearEst;
    data['properties'] = properties;
    data['image'] = image;
    return data;
  }
}
