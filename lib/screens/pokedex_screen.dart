import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:poke_social/models/pokemon_model.dart';
import 'package:poke_social/network/api_pokemon.dart';
import 'package:poke_social/screens/pokemon_detail_screen.dart';
import 'package:poke_social/settings/colors_types_settings.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<PokemonModel>? listPokemon;
  ApiPokemon apiPokemon = ApiPokemon();
  ColorsTypes colorsTypes = ColorsTypes();
  late Map<String, dynamic> colors;

  @override
  void initState() {
    colors = colorsTypes.getColorsTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Pokedex Kanto"),
                ),
                body: listViewPokes());
        }
      },
    );
  }

  initData() async {
    listPokemon = await apiPokemon.getPokemonkanto();
  }

  Widget listViewPokes() {
    return ListView.builder(
        itemBuilder: (context, index) {
          return cardPokemon(listPokemon![index], index * 200);
        },
        itemCount: listPokemon!.length);
  }

  Widget cardPokemon(PokemonModel pokemonModel, int second) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokeDetailScreen(
                      id: pokemonModel.id!,
                      pokemonModel: pokemonModel,
                    )));
      },
      child: FadeInLeftBig(
        delay: Duration(microseconds: 50),
        child: Container(
            margin: EdgeInsets.all(10),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors[pokemonModel.types![0]][0],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
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
                            Text("#${pokemonModel.id!}".toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(pokemonModel.name!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const Icon(Icons.catching_pokemon_outlined),
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
                      color: colors[pokemonModel.types![0]][1],
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
            )),
      ),
    );
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
                  style: TextStyle(
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
}
