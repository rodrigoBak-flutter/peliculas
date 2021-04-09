import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    //Con este controlador modifico la distancia entre las tarjetas horizontales
    initialPage: 1,
    //viewportFraction: es la separacion entre las tarjetas horizontales
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      //_screenSize.height: es la separacion entre Swiper y las tarjetas horizontales
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          //ClipRRect con esta propiedad puedo darle forma a las tarjetas
          Hero(
            tag: pelicula.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                //Tamaño de las tarjetas horizontales Si pongo el heigth en mas de 159, voy a tener un error por el tamaño de mi telefono
                height: 159.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    //Con esta funcion detecto donde estoy tocando con el dedo
    return GestureDetector(
        child: tarjeta,
        onTap: () {
          //Navigator.pushNamed: para pasar de una pagina a otra
          //argumentes: envia todo a la otra pagina, ID, nombre, foto, etc
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
          //print('Nombre de la pelicula ${pelicula.title}');
        });
  }

  //Esta tarjeta no la estoy usando, la conservo para que me quede el codigo
  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            //ClipRRect con esta propiedad puedo darle forma a las tarjetas
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                //Tamaño de las tarjetas horizontales Si pongo el heigth en mas de 159, voy a tener un error por el tamaño de mi telefono
                height: 159.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
