class SearchResModel {
  List<SearchData>? data;
  Meta? meta;

  SearchResModel({this.data, this.meta});

  SearchResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add(SearchData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class SearchData {
  String? id;
  String? url;
  String? shortUrl;
  int? views;
  int? favorites;
  String? source;
  String? purity;
  String? category;
  int? dimensionX;
  int? dimensionY;
  String? resolution;
  String? ratio;
  int? fileSize;
  String? fileType;
  String? createdAt;
  List<String>? colors;
  String? path;
  Thumbs? thumbs;

  SearchData(
      {this.id,
      this.url,
      this.shortUrl,
      this.views,
      this.favorites,
      this.source,
      this.purity,
      this.category,
      this.dimensionX,
      this.dimensionY,
      this.resolution,
      this.ratio,
      this.fileSize,
      this.fileType,
      this.createdAt,
      this.colors,
      this.path,
      this.thumbs});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    shortUrl = json['short_url'];
    views = json['views'];
    favorites = json['favorites'];
    source = json['source'];
    purity = json['purity'];
    category = json['category'];
    dimensionX = json['dimension_x'];
    dimensionY = json['dimension_y'];
    resolution = json['resolution'];
    ratio = json['ratio'];
    fileSize = json['file_size'];
    fileType = json['file_type'];
    createdAt = json['created_at'];
    colors = json['colors'].cast<String>();
    path = json['path'];
    thumbs = json['thumbs'] != null ? Thumbs.fromJson(json['thumbs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['short_url'] = shortUrl;
    data['views'] = views;
    data['favorites'] = favorites;
    data['source'] = source;
    data['purity'] = purity;
    data['category'] = category;
    data['dimension_x'] = dimensionX;
    data['dimension_y'] = dimensionY;
    data['resolution'] = resolution;
    data['ratio'] = ratio;
    data['file_size'] = fileSize;
    data['file_type'] = fileType;
    data['created_at'] = createdAt;
    data['colors'] = colors;
    data['path'] = path;
    if (thumbs != null) {
      data['thumbs'] = thumbs!.toJson();
    }
    return data;
  }
}

class Thumbs {
  String? large;
  String? original;
  String? small;

  Thumbs({this.large, this.original, this.small});

  Thumbs.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    original = json['original'];
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['large'] = large;
    data['original'] = original;
    data['small'] = small;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  String? query;
  String? seed;

  Meta({this.currentPage, this.lastPage, this.perPage, this.total, this.query, this.seed});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    query = json['query'];
    seed = json['seed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    data['query'] = query;
    data['seed'] = seed;
    return data;
  }
}
