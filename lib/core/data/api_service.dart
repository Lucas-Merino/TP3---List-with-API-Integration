import 'package:flutter_application_3/domain/character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ApiService {
  final String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/character'));

    if (response.statusCode == 200) {
      // Decodifica la respuesta y mapea los datos a la lista de personajes
      final data = json.decode(response.body);
      List<Character> characters = (data['results'] as List)
          .map((character) => Character.fromJson(character))
          .toList();

      return characters;
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

   Future<Character> fetchCharacterById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/character/$id'));

    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      final data = json.decode(response.body);
      // Creamos un objeto Character desde el JSON
      return Character.fromJson(data);
    } else {
      throw Exception('Failed to load character with ID: $id');
    }
  }
}