import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:poke_social/models/pokemon_model.dart';
import 'package:poke_social/models/stats_model.dart';
import 'package:poke_social/network/api_pokemon.dart';
import 'package:poke_social/settings/colors_types_settings.dart';

class PokeDetailScreen extends StatefulWidget {
  int id;
  PokemonModel pokemonModel;
  PokeDetailScreen({super.key, required this.id, required this.pokemonModel});

  @override
  State<PokeDetailScreen> createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  ApiPokemon apiPokemon = ApiPokemon();
  ColorsTypes colorsTypes = ColorsTypes();
  late Map<String, dynamic> colors;
  late PokemonModel pokeDeta;
  var response;
  @override
  void initState() {
    colors = colorsTypes.getColorsTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors[widget.pokemonModel.types![0]][2],
        body: FutureBuilder(
          future: initData(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return const Center(
                      child: Center(child: CircularProgressIndicator()));
                }
              case ConnectionState.done:
                return listviewDetails();
            }
          },
        ));
  }

  Widget listviewDetails() {
    return ListView(
      children: [
        cardPokemon(widget.pokemonModel),
        const Text(
          "Info of pokemon",
          style: TextStyle(color: Colors.black, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        FadeInLeftBig(
            delay: const Duration(microseconds: 300), child: cardDesc()),
        const Text(
          "Abilities of pokemon",
          style: TextStyle(color: Colors.black, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        FadeInLeftBig(
            delay: const Duration(microseconds: 400), child: cardAbilities()),
        const Text(
          "Stats of pokemon",
          style: TextStyle(color: Colors.black, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        cardStats()
      ],
    );
  }

  Widget cardDesc() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Text(
            pokeDeta.description!,
            style: TextStyle(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 150,
                  child: ListTile(
                    leading: const Icon(
                      Icons.height,
                      color: Colors.black,
                    ),
                    title: Text(
                      "${pokeDeta.height!.toString()} mts",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
              SizedBox(
                  width: 150,
                  child: ListTile(
                    leading: const Icon(
                      Icons.line_weight,
                      color: Colors.black,
                    ),
                    title: Text(
                      "${pokeDeta.weight!.toString()} kg",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget cardAbilities() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: colors[widget.pokemonModel.types![0]][0],
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Text(
                pokeDeta.hability!,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            pokeDeta.habiHidden != null
                ? Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: colors[widget.pokemonModel.types![0]][2],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: const Text(
                          "Hidden",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: colors[widget.pokemonModel.types![0]][1],
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Text(
                            pokeDeta.habiHidden!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )
                : Text("")
          ],
        ));
  }

  Widget cardStats() {
    int max = getMaxStat();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            for (StatModel statModel in pokeDeta.baseStats!)
              getStat(statModel, max),
            const SizedBox(height: 20),
            Text(
              "Total ${getTotal().toString()}",
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
  }

  Widget getStat(StatModel statModel, int max) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: 100,
            height: 30,
            decoration: BoxDecoration(
                color: colors[widget.pokemonModel.types![0]][2],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Text(
              statModel.name!,
              style: const TextStyle(color: Colors.black, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              lineHeight: 30.0,
              animation: true,
              percent: statModel.baseStat! / max,
              center: Text(
                statModel.baseStat!.toString(),
                style: const TextStyle(fontSize: 12.0),
              ),
              backgroundColor: colors[widget.pokemonModel.types![0]][1],
              progressColor: colors[widget.pokemonModel.types![0]][0],
            ),
          ),
        ],
      ),
    );
  }

  initData() async {
    pokeDeta = await apiPokemon.getDetails(widget.pokemonModel.id!.toString());
  }

  Widget cardPokemon(PokemonModel pokemonModel) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colors[widget.pokemonModel.types![0]][0],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 10))
            ]),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(pokemonModel.id!.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(pokemonModel.name!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const Icon(Icons.favorite),
                      ],
                    ),
                    getRowTypes(pokemonModel.types!)
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                  color: colors[widget.pokemonModel.types![0]][1],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Image.network(
                pokemonModel.sprite!,
                height: 50,
                width: 50,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ));
  }

  Widget getRowTypes(List<String> types) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (String type in types)
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/types/type_${type}.png"),
                    fit: BoxFit.fitWidth,
                  )),
              width: 70,
              height: 40,
              child: Center(
                child: Text(
                  type,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          )
      ],
    );
  }

  int getMaxStat() {
    int max = 0;
    for (StatModel statModel in pokeDeta.baseStats!) {
      if (statModel.baseStat! > max) {
        max = statModel.baseStat!;
      }
    }
    if (max > 100) {
      return max;
    } else {
      return 100;
    }
  }

  int getTotal() {
    int total = 0;
    for (StatModel statModel in pokeDeta.baseStats!) {
      total += statModel.baseStat!;
    }
    return total;
  }
}
