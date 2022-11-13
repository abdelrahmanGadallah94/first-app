import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../businees_logic/cubit/characters_cubit.dart';
import '../../constants/my_Colors.dart';
import '../../data/model/charcters_model.dart';
import '../widgets/character_item.dart';
import '../widgets/searched_textfield.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters;
  final TextEditingController textFieldController = TextEditingController();
  late List<CharactersModel> searchedForCharacters;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    allCharacters =
        BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is LoadedState) {
          allCharacters = state.characters;
          return buildLoadaedListWidget();
        } else {
          return ShowLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadaedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount:
          textFieldController.text.isEmpty ? 12 : searchedForCharacters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        //not done yet
        return CharacterItem(
          character: textFieldController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget ShowLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget _buildsearchedTextField() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: textFieldController,
        onChanged: (searchedCharacter) {
          addSearchedOfItemsToSearchedList(searchedCharacter);
        },
        decoration: const InputDecoration(
            hintText: 'Find a character',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18)),
        style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "characters",
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
    );
  }

  Widget notConnected(){
    return Center(child:  TextLiquidFill(
      text: 'No Internet',
      waveColor: Colors.blueAccent,
      boxBackgroundColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
      boxHeight: 300.0,
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearching ? _buildsearchedTextField() : _buildAppBarTitle(),
        leading: isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : SizedBox(),
        actions: _buildAppBarAction(),
      ),
      body: OfflineBuilder(connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidget();
        } else {
          return notConnected();
        }
      },
        child: ShowLoadingIndicator(),
      ),
    );
  }

  addSearchedOfItemsToSearchedList(searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearData();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
          color: MyColors.myGrey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search),
          color: MyColors.myGrey,
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearData();
    setState(() {
      isSearching = false;
    });
  }

  void _clearData() {
    setState(() {
      textFieldController.clear();
    });
  }
}
