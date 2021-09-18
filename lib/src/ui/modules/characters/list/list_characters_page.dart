import 'package:app_marvel/config/di/di.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_page.dart';
import 'package:app_marvel/src/ui/modules/characters/list/list_characters_cubit.dart';
import 'package:app_marvel/src/ui/shared/states/base_page_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCharactersPage extends StatefulWidget {
  const ListCharactersPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListCharactersPage> createState() => _ListCharactersPageState();
}

class _ListCharactersPageState extends State<ListCharactersPage> {
  ListCharactersCubit listCharactersCubit = getIt<ListCharactersCubit>();
  ScrollController scrollController = ScrollController();
  bool loadingNewItems = false;

  @override
  void initState() {
    super.initState();
    listCharactersCubit.getCharacters();
    scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * scrollController.position.maxScrollExtent;

      if (scrollController.position.pixels > triggerFetchMoreSize) {
        if (loadingNewItems) return;
        setState(() {
          loadingNewItems = true;
        });
        listCharactersCubit.offset += listCharactersCubit.limit;
        listCharactersCubit.getCharacters();
        Future.delayed(const Duration(seconds: 2)).then((value) {
          setState(() {
            loadingNewItems = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Lista de Personagens',
        ),
      ),
      body: BlocBuilder<ListCharactersCubit, BaseState>(
        bloc: listCharactersCubit,
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  OutlinedButton(
                    onPressed: () {
                      listCharactersCubit.getCharacters();
                    },
                    child: const Text('Reload'),
                  ),
                ],
              ),
            );
          }

          if (state is SuccessState) {
            return _buildCharactersList();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildCharactersList() {
    return ListView.builder(
      controller: scrollController,
      itemCount: listCharactersCubit.characters.length,
      itemBuilder: (_, index) {
        final character = listCharactersCubit.characters[index];
        if (loadingNewItems &&
            (listCharactersCubit.characters.length - 1) == index) {
          return Column(
            children: [
              _buildCharacterListTile(character, index),
              _buildLoadingListTile(index - 1),
            ],
          );
        }
        return _buildCharacterListTile(character, index);
      },
    );
  }

  Widget _buildCharacterListTile(
    CharacterModel character,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailCharacterPage(
              character: character,
            ),
          ),
        );
      },
      child: Container(
        color: index.isEven ? Colors.red[100] : Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                character.imageSmall,
              ),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(character.name),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingListTile(int index) {
    return Container(
      color: index.isEven ? Colors.red[100] : Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
