import 'package:bloc_task/businees_logic/cubit/qoutes_cubit.dart';
import 'package:bloc_task/data/model/charcters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/my_Colors.dart';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final CharactersModel characters;

  const CharactersDetailsScreen({super.key, required this.characters});

  //buildSliverAppBar widget
  Widget buildSliverAppBar() {
    // image and name
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          characters.nickName,

          style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 25,
              fontWeight: FontWeight.bold),
          // textAlign: TextAlign.left,
        ),
        background: Hero(
          tag: characters.charId,
          child: Image.network(
            characters.images,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  //characterInfo widget
  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhite,
              )),
        ],
      ),
    );
  }

  //buildDivider widget
  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(state) {
    if (state is QuotesLoadState) {
      return displayRandomTextOrEmptySpace(state);
    } else {
      return ShowProgressIndicator();
    }
  }

  Widget displayRandomTextOrEmptySpace(state) {
    var quotes = state.quotes;
    if (quotes.length != 0) {
      int randoQuoteIndex = Random().nextInt(quotes.length - 1);
      return DefaultTextStyle(
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ]),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(quotes[randoQuoteIndex].quote.toString()),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget ShowProgressIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.myYellow,
    ));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuotesCubit>(context).getAllRepositories(characters.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Jobs: ', characters.jobs.join(' / ')),
                      buildDivider(315),
                      characterInfo(
                          'Appeared In: ', characters.categoryOfTwoSeries),
                      buildDivider(255),
                      characterInfo('Seasons: ',
                          characters.appearanceOfSeries.join(' / ')),
                      buildDivider(280),
                      characterInfo('status: ', characters.statusOfDeadOrAlive),
                      buildDivider(300),
                      characters.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('Better call saul season: ',
                              characters.betterCallSaulAppearance.join(' / ')),
                      characters.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(170),
                      characterInfo('Actor name: ', characters.actorName),
                      buildDivider(260),
                      const SizedBox(height: 20),
                      BlocBuilder<QuotesCubit, QuotesState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
