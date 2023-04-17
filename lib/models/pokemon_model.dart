import 'package:poke_social/models/stats_model.dart';

class PokemonModel {
  int? id;
  String? name;
  String? sprite;
  List<String>? types;
  String? description;
  double? height;
  double? weight;
  String? hability;
  String? habiHidden;
  List<StatModel>? baseStats;
  List<PokemonModel>? evolChain;

  PokemonModel(
      {this.id,
      this.name,
      this.sprite,
      this.types,
      this.description,
      this.height,
      this.weight,
      this.hability,
      this.habiHidden,
      this.baseStats,
      this.evolChain});
  //PokemonModel.add(this.id, this.name, this.sprite, this.types);

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
        id: map['id_movie'],
        name: map['name'],
        sprite: map['posterPath'],
        types: map['types']);
  }
}
