class CharacterModel {
  String id;
  String name;
  String description;
  String imageSmall;
  String imageLarge;
  String imageMedium;

  // ComicListModel? comics;

  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageSmall,
    required this.imageLarge,
    required this.imageMedium,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      description: map['description'].toString(),
      imageSmall:
          '${map['thumbnail']['path'].toString()}/standard_small.${map['thumbnail']['extension']}',
      imageMedium:
          '${map['thumbnail']['path'].toString()}/standard_medium.${map['thumbnail']['extension']}',
      imageLarge:
          '${map['thumbnail']['path'].toString()}/standard_fantastic.${map['thumbnail']['extension']}',
    );
  }
}
