class MovieModel {
  MovieModel({
      this.page, 
      this.perPage, 
      this.totalItems, 
      this.totalPages, 
      this.items,});

  MovieModel.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['perPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  int? page;
  int? perPage;
  int? totalItems;
  int? totalPages;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['perPage'] = perPage;
    map['totalItems'] = totalItems;
    map['totalPages'] = totalPages;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      this.category, 
      this.collectionId, 
      this.collectionName, 
      this.created, 
      this.desc, 
      this.id, 
      this.imageUrl, 
      this.title, 
      this.updated,});

  Items.fromJson(dynamic json) {
    category = json['category'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    desc = json['desc'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    updated = json['updated'];
  }
  String? category;
  String? collectionId;
  String? collectionName;
  String? created;
  String? desc;
  String? id;
  String? imageUrl;
  String? title;
  String? updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['collectionId'] = collectionId;
    map['collectionName'] = collectionName;
    map['created'] = created;
    map['desc'] = desc;
    map['id'] = id;
    map['imageUrl'] = imageUrl;
    map['title'] = title;
    map['updated'] = updated;
    return map;
  }

}