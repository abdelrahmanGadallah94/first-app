part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
class LoadedState extends CharactersState{
  final List<CharactersModel> characters;
  LoadedState(this.characters);
}