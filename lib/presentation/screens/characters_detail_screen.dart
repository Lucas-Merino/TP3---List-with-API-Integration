
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/data/api_service.dart';
import 'package:flutter_application_3/domain/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({
    super.key,
    required this.characterId,
  });

  static const String name = 'character_details_screen';
  final String characterId;

  @override
  Widget build(BuildContext context){
    final int id = int.tryParse(characterId) ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
      ),
      body: FutureBuilder<Character>(
        future: ApiService().fetchCharacterById(id), // Obtener los detalles del personaje desde la API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Character not found.'));
          } else {
            final character = snapshot.data!;
            return _CharacterDetailView(character: character);
          }
        },
      ),
    );
  }
}


class _CharacterDetailView extends StatelessWidget {
  const _CharacterDetailView({
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          if (character.image != null) Image.network(character.image!, height: 400),
          const SizedBox(height: 16),
          Text(
            character.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Status: ${character.status}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Specie: ${character.species}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}