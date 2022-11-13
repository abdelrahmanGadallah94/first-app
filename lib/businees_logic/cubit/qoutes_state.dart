part of 'qoutes_cubit.dart';

@immutable
abstract class QuotesState {}

class QuotesInitial extends QuotesState {}
class QuotesLoadState extends QuotesState{
  final List<Quotes> quotes;

  QuotesLoadState(this.quotes);
}