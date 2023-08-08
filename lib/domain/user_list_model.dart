import 'dart:convert';

UserModel userListFromJson(String str) => UserModel.fromJson(json.decode(str));

String userListToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<DatumModel> data;
  SupportModel support;

  UserModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data: List<DatumModel>.from(json["data"].map((x) => DatumModel.fromJson(x))),
    support: SupportModel.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "support": support.toJson(),
  };
}

class DatumModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  DatumModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory DatumModel.fromJson(Map<String, dynamic> json) => DatumModel(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };

}

class SupportModel {
  String url;
  String text;

  SupportModel({
    required this.url,
    required this.text,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}