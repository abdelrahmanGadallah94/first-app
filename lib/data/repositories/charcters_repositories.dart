import '../model/charcters_model.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepositories {
  final CharactersWebServices charactersServices;

  CharactersRepositories(this.charactersServices);

  Future<List<CharactersModel>> fetchData() async {
    final characters = await charactersServices.getAllCharacters();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}
