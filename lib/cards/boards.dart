import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gest_proc/access/access_page.dart';
import 'package:gest_proc/cards/qr_scan.dart';
import 'package:gest_proc/globals/user_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'board_details.dart';

class Boards extends StatefulWidget {

  final User currentUs;

  Boards(this.currentUs);

  @override
  _BoardState createState() => _BoardState();

}

class _BoardState extends State<Boards>{

  final TextEditingController _seekController = TextEditingController();
  late FocusNode userFN = FocusNode();

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){

          },
          //No existe nombre en el respose principal
          child: Text('Usuario correcto'),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF000000),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          await  _getCameraPermission();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return QRViewExample();
              }));
        },
        child: const Icon(Icons.qr_code),
        backgroundColor: const Color(0xFF000000),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox(height: 15,),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
              controller: _seekController,
              focusNode: userFN,
              autofocus: false,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline6,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Buscar por ID',
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                contentPadding: const EdgeInsets.only(left: 25, right: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: (){
                    userFN.unfocus();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return BoardsDetails(int.parse(_seekController.text));
                        })).whenComplete(() => _seekController.clear());
                  },
                )
              ),
              onEditingComplete: () {
                userFN.unfocus();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return BoardsDetails(int.parse(_seekController.text));
                    })).whenComplete(() => _seekController.clear());
              },
            ),
          ),

          const SizedBox(height: 15,),

          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              padding: const EdgeInsets.only(bottom: 15, top: 15, left: 15, right: 15),
              clipBehavior: Clip.none,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return AccessPage();
                      }));
                },
                leading: Icon(Icons.add ),
                title: const Text(
                  'Control de acceso',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                subtitle: const Text(
                  'Buscar acceso',
                  style: TextStyle(
                      color: Colors.black),
                ),
                // trailing: Text('5'),
              ))),

          const SizedBox(height: 10,),

          // SelectableText(responsePrincipal.toString()),
          // const SizedBox(height: 10,),
          // SelectableText(responseGlobal.toString()),

          Expanded(child:
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))
                ),
                child: _body()
              ),
            ),
          ),

        ],
      ),
    );
  }

  _body(){
    return  SingleChildScrollView(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 4,//jsonDecode(responseGlobal)['Data']['ProcessPermission'].toString().length,
          itemBuilder: (context, index) {
            return Center(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 15, top: 15, left: 15, right: 15),
                  clipBehavior: Clip.none,
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20))),
                  child: ListTile(
                    onTap: () async {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return BoardsDetails(index);
                          }));
                    },
                    leading: _status(responsePrincipal['Data'][index]['Status']),
                    title: Text(
                      responsePrincipal['Data'][index]['Name'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                    subtitle: Text(
                      responsePrincipal['Data'][index]['Status'],
                      style: const TextStyle(
                          color: Colors.black),
                    ),
                    // trailing: Text('5'),
                  )));
          }),
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
        return Icon(
          Icons.book,
          color: _color(index),
          size: 36.0,
        );
      case 'Solicitudes de Acceso':
        return Icon(
          Icons.person_add,
          color: _color(index),
          size: 36.0,
        );
      case 'Alta Empleado':
        return Icon(
          Icons.person_add,
          color: _color(index),
          size: 36.0,
        );
      case 'Solicitudes de Huesped':
        return Icon(
          Icons.checkroom,
          color: _color(index),
          size: 36.0,
        );
      case 'Calendarización':
        return Icon(
          Icons.calendar_today,
          color: _color(index),
          size: 36.0,
        );
      case 'Acceso':
        return Icon(
          Icons.accessibility,
          color: _color(index),
          size: 36.0,
        );
      default:
        return Icon(
          Icons.remove_red_eye,
          color: _color(index),
          size: 36.0,
        );
    }
  }

  _status(String index){

    double iconSize = 36.0;

    switch(index){
      case 'Accepted':
        return Icon(
          Icons.check,
          color: Colors.green,
          size: iconSize,
        );
      case 'In progress':
        return Icon(
          Icons.warning,
          color: Colors.yellow,
          size: iconSize,
        );
      case 'Rejected':
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