import 'package:app_marvel/config/di/di.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/models/comic_model.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_cubit.dart';
import 'package:app_marvel/src/ui/shared/states/base_page_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCharacterPage extends StatefulWidget {
  final CharacterModel character;

  const DetailCharacterPage({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailCharacterPage> createState() => _DetailCharacterPageState();
}

class _DetailCharacterPageState extends State<DetailCharacterPage> {
  final detailCharacterCubit = getIt<DetailCharacterCubit>();

  @override
  void initState() {
    super.initState();
    detailCharacterCubit.getCharacters(widget.character.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    widget.character.imageLarge,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    _buildDescription(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<DetailCharacterCubit, BaseState>(
              bloc: detailCharacterCubit,
              builder: (context, state) {
                if (state is ErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is SuccessState<List<ComicModel>>) {
                  return _buildComics(state.data);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _buildDescription() {
    if (widget.character.description.isEmpty) {
      return 'Sem descrição.';
    }
    return widget.character.description;
  }

  Widget _buildComics(List<ComicModel> comics) {
    if (comics.isEmpty) {
      return const Text(
        'Nenhum quadrinho relacionado foi encontrado.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
    }
    final list = <Widget>[];

    for (var comic in comics) {
      list.add(
        Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                comic.imageLarge,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 10,
      spacing: 10,
      children: list,
    );
  }
}
