import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/character.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    super.key,
    required this.character,
    this.onTap,
  });

  final Character character;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: character.image != null
            ? _getPoster(character.image!)
            : const Text('No image available'),
        title: Text(character.name),
        subtitle: Text('Status: ${character.status}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => onTap?.call(),
      ),
    );
  }

  Widget _getPoster(String posterUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(posterUrl),
    );
  }
}