// To parse this JSON data, do
//
//     final charModel = charModelFromJson(jsonString);

import 'dart:convert';

CharModel charModelFromJson(String str) => CharModel.fromJson(json.decode(str));

String charModelToJson(CharModel data) => json.encode(data.toJson());

class CharModel {
  CharModel({
    this.error,
    this.message,
    this.payload,
  });

  bool error;
  String message;
  Payload payload;

  factory CharModel.fromJson(Map<String, dynamic> json) => CharModel(
    error: json["error"],
    message: json["message"],
    payload: Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "payload": payload.toJson(),
  };
}

class Payload {
  Payload({
    this.characters,
  });

  List<Character> characters;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    characters: List<Character>.from(json["characters"].map((x) => Character.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "characters": List<dynamic>.from(characters.map((x) => x.toJson())),
  };
}

class Character {
  Character({
    this.name,
    this.element,
    this.weaponType,
    this.birthday,
    this.description,
    this.cardImageUrl,
    this.iconUrl,
    this.compressedImageUrl,
    this.rarity,
    this.title,
    this.gender,
  });

  String name;
  String element;
  WeaponType weaponType;
  String birthday;
  String description;
  String cardImageUrl;
  String iconUrl;
  String compressedImageUrl;
  int rarity;
  String title;
  String gender;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    name: json["name"],
    element: json["element"],
    weaponType: weaponTypeValues.map[json["weaponType"]],
    birthday: json["birthday"],
    description: json["description"],
    cardImageUrl: json["cardImageURL"],
    iconUrl: json["iconURL"],
    compressedImageUrl: json["compressedImageURL"],
    rarity: json["rarity"],
    title: json["title"] == null ? null : json["title"],
    gender: json["gender"] == null ? null : json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "element": element,
    "weaponType": weaponTypeValues.reverse[weaponType],
    "birthday": birthday,
    "description": description,
    "cardImageURL": cardImageUrl,
    "iconURL": iconUrl,
    "compressedImageURL": compressedImageUrl,
    "rarity": rarity,
    "title": title == null ? null : title,
    "gender": gender == null ? null : gender,
  };
}

enum WeaponType { SWORD, BOW, CATALYST, CLAYMORE, POLEARM }

final weaponTypeValues = EnumValues({
  "Bow": WeaponType.BOW,
  "Catalyst": WeaponType.CATALYST,
  "Claymore": WeaponType.CLAYMORE,
  "Polearm": WeaponType.POLEARM,
  "Sword": WeaponType.SWORD
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
