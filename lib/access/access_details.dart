import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gest_proc/cards/card_page.dart';
import 'package:gest_proc/globals/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:gest_proc/helpers/size_config.dart';

//cambiar estatus

class AccessDetails extends StatefulWidget {

  final String persona;

  AccessDetails(this.persona);

  @override
  AccessDetailstate createState() => AccessDetailstate();

}

class AccessDetailstate extends State<AccessDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {

          },
          child: Text(widget.persona),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF000000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox(height: 15,),

          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: BoxDecoration(
                // color: _color(jsonDecode(responseGlobal)['Data']['ProcessPermission'][widget.index]['Name']),
                  color: Colors.white,
                  // border: Border.all(color: _color(jsonDecode(responseGlobal)['Data']['ProcessPermission'][widget.index]['Name']),),
                  borderRadius: const BorderRadius.all(Radius.circular(40.0))
              ),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _status('Aceptado'),
                      // _icon(jsonDecode(responseGlobal)['Data']['ProcessPermission'][widget.index]['Name']),
                    ],
                  ),

                  SelectableText(
                    widget.persona
                  ),

                  // SelectableText(example['Nombre'].toString()),

                  // Text(jsonDecode(responseGlobal)['Data']['ProcessPermission'][widget.index]['PermissionId'])
                ],
              ),
            ),
          ),

        ],
      ),
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

    Color iconColor = _color(index);
    double iconSize = 24.0;

    switch(index){
      case 'Solicitudes de Empleado':
        return Icon(
          Icons.book,
          color: iconColor,
          size: iconSize,
        );
      case 'Solicitudes de Acceso':
        return Icon(
          Icons.person_add,
          color: iconColor,
          size: iconSize,
        );
      case 'Alta Empleado':
        return Icon(
          Icons.person_add,
          color: iconColor,
          size: iconSize,
        );
      case 'Solicitudes de Huesped':
        return Icon(
          Icons.checkroom,
          color: iconColor,
          size: iconSize,
        );
      case 'Calendarización':
        return Icon(
          Icons.calendar_today,
          color: iconColor,
          size: iconSize,
        );
      case 'Acceso':
        return Icon(
          Icons.accessibility,
          color: iconColor,
          size: iconSize,
        );
      default:
        return Icon(
          Icons.remove_red_eye,
          color: iconColor,
          size: iconSize,
        );
    }
  }

  _status(String index){

    double iconSize = 90.0;

    switch(index){
      case 'Aceptado':
        return Icon(
          Icons.check,
          color: Colors.green,
          size: iconSize,
        );
      case 'En progreso':
        return Icon(
          Icons.warning,
          color: Colors.yellow,
          size: iconSize,
        );
      case 'Rechazado':
        return Icon(
          Icons.error,
          color: Colors.red,
          size: iconSize,
        );
    // case 'Iniciado':
    //   return Icon(
    //     Icons.error,
    //     color: Colors.black,
    //     size: iconSize,
    //   );
      default:
        return Icon(
          Icons.remove_red_eye,
          color: Colors.black,
          size: iconSize,
        );
    }
  }

}