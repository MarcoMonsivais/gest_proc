import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gest_proc/globals/user_model.dart';

class CardPage extends StatefulWidget {

  final User currentUs;

  CardPage(this.currentUs);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {

  final PageController _controller = PageController(initialPage: 0, viewportFraction: 1.1);
  late Color _colorContainer = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _key,
      body: Stack(
          children: [

            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/backgrounds/back-3.jpg"),
                        fit: BoxFit.fill))
            ),

            Center(
              child: Container(
                  margin: const EdgeInsets.all(10.0),
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  child: Column(
                    children: [

                      const SizedBox(height: 15,),

                      Center(child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(jsonDecode(responseGlobal)['Data']['Name'], style: const TextStyle(fontSize: 20.0),)),),

                      const SizedBox(height: 15,),

                      Container(
                        height: MediaQuery.of(context).size.height * 0.73,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40.0))
                        ),
                        child: PageView.builder (
                            itemCount: 13,
                            scrollDirection: Axis.horizontal,
                            controller: _controller,
                            itemBuilder: (context, position) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                height: MediaQuery.of(context).size.height * 0.73,
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                    color: _color(jsonDecode(responseGlobal)['Data']['ProcessPermission'][position]['Name']),
                                    borderRadius: const BorderRadius.all(Radius.circular(40.0))
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      const SizedBox(height: 20,),

                                      _icon(jsonDecode(responseGlobal)['Data']['ProcessPermission'][position]['Name']),

                                      const SizedBox(height: 35,),

                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.65,
                                          child: Text(
                                            jsonDecode(responseGlobal)['Data']['ProcessPermission'][position]['Name'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(color: Colors.black, fontSize: 15.0),
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                        ),
                      ),

                    ],
                  )
              ),
            ),

          ]),
    );
  }

  _color(String index){
    switch(index){
      case 'Solicitudes de Empleado':
        return Colors.orangeAccent;
      case 'Solicitudes de Acceso':
        return Colors.purpleAccent;
      case 'Alta Empleado':
        return Colors.blue;
      case 'Solicitudes de Huesped':
        return Colors.indigoAccent;
      case 'Calendarización':
        return Colors.grey;
      case 'Acceso':
        return Colors.tealAccent;
      default:
        return Colors.pinkAccent;
    }
  }

  _icon(String index){
    switch(index){
      case 'Solicitudes de Empleado':
        return const Icon(
          Icons.book,
          color: Colors.white,
          size: 36.0,
        );
      case 'Solicitudes de Acceso':
        return const Icon(
          Icons.person_add,
          color: Colors.white,
          size: 36.0,
        );
      case 'Alta Empleado':
        return const Icon(
          Icons.person_add,
          color: Colors.white,
          size: 36.0,
        );
      case 'Solicitudes de Huesped':
        return const Icon(
          Icons.checkroom,
          color: Colors.white,
          size: 36.0,
        );
      case 'Calendarización':
        return const Icon(
          Icons.calendar_today,
          color: Colors.white,
          size: 36.0,
        );
      case 'Acceso':
        return const Icon(
          Icons.accessibility,
          color: Colors.white,
          size: 36.0,
        );
      default:
        return const Icon(
          Icons.remove_red_eye,
          color: Colors.white,
          size: 36.0,
        );
    }
  }

}