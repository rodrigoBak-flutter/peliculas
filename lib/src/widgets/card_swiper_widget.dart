//hay que importar esta clase para poder usar las tarjetas Swipers
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //Mostrar la lista que quiero mostrar en las tarjetas
  final List<Pelicula> peliculas;
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //para configurar tamaño del dispositivo que uso
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        //Probar alores en SwiperLayout. para ver las variantes
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        //Con 0,43 de height mi movil ya me lanza un error, porque se excede de la pantalla
        itemHeight: _screenSize.height * 0.42,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage(
                image: NetworkImage(peliculas[index].getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ));
        },
        itemCount: peliculas.length,
        //pagination = hace que se muestren los puntitos debajo de las fotos
        //pagination: new SwiperPagination(),
        //control = hace que se muestren las flechas para deslizar en la derecha e izquierda
        // control: new SwiperControl(),
      ),
    );
  }
}
