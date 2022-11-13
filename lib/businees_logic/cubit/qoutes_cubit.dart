import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/qoutes.dart';
import '../../data/repositories/quotes_repository.dart';

part 'qoutes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {

  final QuotesRepository quotesRepository;
  QuotesCubit(this.quotesRepository) : super(QuotesInitial());

  void getAllRepositories(String charName){
    quotesRepository.fetchQuotes(charName).then((quote) {
      emit(QuotesLoadState(quote));
    });
  }
}
