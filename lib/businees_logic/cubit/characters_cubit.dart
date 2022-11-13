import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../data/model/charcters_model.dart';
import '../../data/repositories/charcters_repositories.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepositories charactersRepositories;
   List<CharactersModel> characters = [];
  CharactersCubit(this.charactersRepositories) : super(CharactersInitial());

  List<CharactersModel> getAllCharacters(){
    charactersRepositories.fetchData().then((character){
      characters = character;
      emit(LoadedState(character));
    });
    return characters;
  }
}
