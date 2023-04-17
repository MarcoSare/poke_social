import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poke_social/models/pokemon_model.dart';
import 'package:poke_social/models/stats_model.dart';

class ApiPokemon {
  Future<List<PokemonModel>> getPokemonkanto() async {
    List<int> ids = List.empty(growable: true);
    for (int i = 1; 151 > i; i++) ids.add(i);
    return Future.wait<PokemonModel>(ids.map((id) => http
            .get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${id}/'))
            .then((value) {
          var response = json.decode(value.body);
          return (PokemonModel(
              id: id,
              name: response["pokemon"]["name"],
              sprite:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${id}.png",
              types: _getTypes(response["types"])));
        })));
  }

  Future<PokemonModel> getDetails(String id) async {
    //PokemonModel pokemonModel = PokemonModel();
    List<dynamic> futures =
        await Future.wait([getResDeta(id), getDescription(id)]);
    var listStats = futures[0]["stats"] as List;
    //listStats.length
    return PokemonModel(
        id: int.parse(id),
        name: futures[0]["forms"][0]["name"],
        sprite:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${id}.png",
        types: _getTypes(futures[0]["types"]),
        description: futures[1],
        height: futures[0]["height"] / 10,
        weight: futures[0]["weight"] / 10,
        hability: futures[0]["abilities"][0]["ability"]["name"],
        habiHidden: futures[0]["abilities"].length > 1
            ? futures[0]["abilities"][1]["ability"]["name"]
            : null,
        baseStats: listStats.map((stat) => StatModel.fromMap(stat)).toList());
  }

  Future<Map<String, dynamic>> getResDeta(String id) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/${id}/");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      var datos = json.decode(result.body);
      return datos;
    }
    return {'error': "Error inesperado"};
  }

  Future<String> getDescription(String id) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon-species/${id}/");
    var data = await http.get(url);
    var response = json.decode(data.body);
    var textEntries = response["flavor_text_entries"];
    for (var item in textEntries) {
      if (item["version"]["name"] == "firered") return item["flavor_text"];
    }
    return "";
  }

  List<String> _getTypes(var list) {
    List<String> types = List.empty(growable: true);
    for (var item in list) {
      types.add(item["type"]["name"]);
    }
    return types;
  }
}
