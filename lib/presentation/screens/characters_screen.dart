import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/data/api_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_3/core/data/characters_repository.dart';
import 'package:flutter_application_3/presentation/screens/characters_detail_screen.dart';
import 'package:flutter_application_3/presentation/widgets/character_item.dart';
import 'package:flutter_application_3/domain/character.dart';

class CharactersScreen extends StatelessWidget {
  static const String name = 'characters_screen';
  final List<Character> characters = characterList;

  CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick & Morty: Characters"),
      ),
      body: const _CharactersView(),
    );
  }
}

class _CharactersView extends StatelessWidget {
  const _CharactersView();

  @override
  Widget build(BuildContext context) {
    // Usamos FutureBuilder para manejar los datos asíncronos desde la API
    return FutureBuilder<List<Character>>(
      future: ApiService().fetchCharacters(), // Llamada a la API desde el repositorio
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron personajes.'));
        } else {
          final characters = snapshot.data!;
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return CharacterItem(
                character: character,
                onTap: () => _goToCharacterDetails(context, character),
              );
            },
          );
        }
      },
    );
  }

  void _goToCharacterDetails(BuildContext context, Character character) {
    context.pushNamed(
      CharacterDetailScreen.name,
      pathParameters: {
        'characterId': character.id.toString(),
      },
    );
  }
}