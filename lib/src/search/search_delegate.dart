import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_modal.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  final peliculas = [
    'Spiderman',
    'Aquaman', 
    'Batman',
    'Shazam',
    'Ironman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Capitan America'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );    
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child :  Container(
        height: 100.0,  
        width: 100.0,
        color : Colors.blueAccent,
        child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){

          final List<Pelicula> peliculas = snapshot.data;

          return ListView(
            children: 
              peliculas.map((pelicula){
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit : BoxFit.contain
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList(),
          );  
        }else{
          return  Center( child: CircularProgressIndicator(),);
        }
        
      },
    );

  }
  // @override
  // Widget buildSuggestions(BuildContext context) {

  //   final listSugerida = (query.isEmpty) ? peliculasRecientes : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: listSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listSugerida[i]),
  //         onTap: (){
  //            seleccion = listSugerida[i];
  //            showResults(context);
  //         }
  //       );
  //     },
  //   );
  // }

}