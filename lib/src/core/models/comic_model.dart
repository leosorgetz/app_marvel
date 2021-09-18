class ComicModel {
  String imageSmall;
  String imageMedium;
  String imageLarge;

  ComicModel({
    required this.imageSmall,
    required this.imageMedium,
    required this.imageLarge,
  });

  factory ComicModel.fromJson(Map<String, dynamic> map) {
    return ComicModel(
      imageSmall:
          '${map['thumbnail']['path'].toString()}/standard_small.${map['thumbnail']['extension']}',
      imageMedium:
          '${map['thumbnail']['path'].toString()}/standard_medium.${map['thumbnail']['extension']}',
      imageLarge:
          '${map['thumbnail']['path'].toString()}/standard_fantastic.${map['thumbnail']['extension']}',
    );
  }
}
