class CharactersModel{
  late int charId ;
  late String name;
  late List<dynamic> jobs;
  late String images;
  late String statusOfDeadOrAlive;
  late String nickName;
  late List<dynamic> appearanceOfSeries;
  late String actorName;
  late String categoryOfTwoSeries;
  late List<dynamic> betterCallSaulAppearance;

  CharactersModel.fromJson(Map<String, dynamic> json){
    charId = json["char_id"];
    name = json["name"];
    jobs = json["occupation"];
    images = json["img"];
    statusOfDeadOrAlive = json["status"];
    nickName = json["nickname"];
    appearanceOfSeries = json["appearance"];
    actorName = json["portrayed"];
    categoryOfTwoSeries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}