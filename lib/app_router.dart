import 'package:bloc_task/data/model/charcters_model.dart';
import 'package:bloc_task/data/repositories/charcters_repositories.dart';
import 'package:bloc_task/presentation/screens/charcters_details_screen.dart';
import 'package:bloc_task/presentation/screens/chracters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'businees_logic/cubit/characters_cubit.dart';
import 'businees_logic/cubit/qoutes_cubit.dart';
import 'constants/strings.dart';
import 'data/repositories/quotes_repository.dart';
import 'data/web_services/characters_web_services.dart';
import 'data/web_services/quotes_web_services.dart';

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharactersRepositories charactersRepositories;
  late QuotesRepository quotesRepository;

  AppRouter() {
    charactersRepositories = CharactersRepositories(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepositories);
    quotesRepository = QuotesRepository(QuoteWebServices());
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const CharactersScreen(),
                ));
      case charactersDetailsScreen:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => QuotesCubit(quotesRepository),
                  child: CharactersDetailsScreen(characters: character),
                ));
    }
  }
}