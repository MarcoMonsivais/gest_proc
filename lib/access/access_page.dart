import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gest_proc/cards/board_details.dart';
import 'package:gest_proc/cards/board_multi_details.dart';
import 'package:gest_proc/globals/user_model.dart';
import 'access_details.dart';

class AccessPage extends StatefulWidget {

  @override
  AccessPagetate createState() => AccessPagetate();

}

class AccessPagetate extends State<AccessPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de acceso'),
        centerTitle: true,
        backgroundColor: Color(0xFF000000),
      ),
      body: SafeArea(
        child: _body()
      ),

    );
  }

  _body(){
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: exampleJson['Accesos Multiples']!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('https://icons.iconarchive.com/icons/custom-icon-design/silky-line-user/256/user-add-icon.png'),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  exampleJson['Accesos Multiples']!['Persona ' + index.toString()]!['Nombre'].toString()
                ),
                const SizedBox(width: 10,),
                Text(
                  exampleJson['Accesos Multiples']!['Persona ' + index.toString()]!['ocupacion'].toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
            subtitle: Text(exampleJson['Accesos Multiples']!['Persona ' + index.toString()]!['telefono'].toString()),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () async {

              // await availableCameras().then((value) =>
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return BoardsMultiDetails(index,camera);
                  }));
              // );

            },
          );
        }
    );
  }

  var exampleJson = {
    "Accesos Multiples": {
      "Persona 0": {
        "Nombre": "Arturo Pérez Navarro",
        "credencial": "http://flostatemachineapp.com/uplaods/credencial",
        "ocupacion": "programador",
        "telefono": "8132648071"
      },
      "Persona 1": {
        "Nombre": "Marco Monsivais",
        "credencial": "http://flostatemachineapp.com/uplaods/credencial",
        "ocupacion": "asistente",
        "telefono": "8113480079"
      },
      "Persona 2": {
        "Nombre": "Antonio Arizmendi",
        "credencial": "http://flostatemachineapp.com/uplaods/credencial",
        "ocupacion": "programador",
        "telefono": "8115778979"
      },
      "Persona 3": {
        "Nombre": "Karla Cobos",
        "credencial": "http://flostatemachineapp.com/uplaods/credencial",
        "ocupacion": "paralegal",
        "telefono": "8112878071"
      },
      "Persona 4": {
        "Nombre": "Vincent Vega",
        "credencial": "http://flostatemachineapp.com/uplaods/credencial",
        "ocupacion": "gerente",
        "telefono": "8118979577"
      },
    }
  };

}