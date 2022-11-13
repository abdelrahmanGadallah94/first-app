import '../model/qoutes.dart';
import '../web_services/quotes_web_services.dart';

class QuotesRepository{
  final QuoteWebServices quoteWebServices;

  QuotesRepository(this.quoteWebServices);

  Future<List<Quotes>> fetchQuotes(String charName)async{
    final quotes = await quoteWebServices.getAllQuotes(charName);
    return quotes.map((quote) => Quotes.fromJson(quote)).toList();
  }
}