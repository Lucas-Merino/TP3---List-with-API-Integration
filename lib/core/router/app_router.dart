import 'package:go_router/go_router.dart';
import 'package:flutter_application_3/presentation/screens/characters_detail_screen.dart';
import 'package:flutter_application_3/presentation/screens/characters_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: CharactersScreen.name,
      path: '/',
      builder: (context, state) => CharactersScreen(),
    ),
    GoRoute(
      name: CharacterDetailScreen.name,
      path: '/character-detail/:characterId',
      builder: (context, state) {
        final characterId = state.pathParameters['characterId'];
        return CharacterDetailScreen(
          characterId: characterId!
        );
      },
    ),
  ],
);