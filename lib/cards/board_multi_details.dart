import 'package:gest_proc/globals/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';

class BoardsMultiDetails extends StatefulWidget {

  final int index;
  final CameraDescription camera;

  BoardsMultiDetails(this.index, this.camera);

  @override
  BoardsMultiDetailstate createState() => BoardsMultiDetailstate();

}

class BoardsMultiDetailstate extends State<BoardsMultiDetails> {

  double padBottom = 8;
  double padTop = 8;
  bool imageSelected = false;

  late XFile image;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {

            },
            child: Text(responseDetalle['Data'][0]['Name']),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF000000),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 20,),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.80,
                padding: const EdgeInsets.only(left: 25, right: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40.0))
                ),
                margin: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _status(responseDetalle['Data'][0]['Status'].toString()),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showMenu<String>(
                                    context: context,
                                    position: const RelativeRect.fromLTRB(0.0, 0.0, -10.0, -25.0),
                                    items: [
                                        const PopupMenuItem<String>(
                                            child: Text('Reportar'), value: 'Reportar'),
                                        const PopupMenuDivider(),
                                        const PopupMenuItem<String>(
                                            child: Text('Cancelar'), value: '3'),
                                      ],
                                      elevation: 8.0,
                                    ).then((value) {
                                      if(value == 'Reportar') {
                                        Alert(
                                          context: context,
                                          title: "REPORTAR",
                                          content: Column(
                                            children: const <Widget>[
                                              //nombre, descripcion, severidad del fallo, departamento,fecha/hora,ubicacion
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.person),
                                                  labelText: 'Nombre',
                                                ),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.local_fire_department),
                                                  labelText: 'Severidad',
                                                ),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.category),
                                                  labelText: 'Departamento',
                                                ),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.date_range),
                                                  labelText: 'Fecha hora',
                                                ),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.location_on),
                                                  labelText: 'Ubicación',
                                                ),
                                              ),
                                              TextField(
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  labelText: 'Descripción',
                                                ),
                                              ),
                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text(
                                                "REPORTAR",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                            )
                                          ]).show();
                                      }
                                  });
                                },
                                child: const Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    // color: Colors.yellow,
                                    height: 17,
                                    width: 25,
                                    child: Icon(Icons.dehaze)
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15,),
                              const Text('Fecha de creación: ', style: TextStyle(fontSize: 16),),
                              Text( DateFormat.yMMMEd().format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(responseDetalle['Data'][0]['CreatedAt'].toString().replaceAll('T', ' '))),),
                              // Text(responseDetalle['Data'][0]['CreatedAt']),

                              const SizedBox(height: 10,),
                              const Text('Última actualización: ', style: TextStyle(fontSize: 16),),
                              Text( DateFormat.yMMMEd().format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(responseDetalle['Data'][0]['UpdatedAt'].toString().replaceAll('T', ' '))),),
                              // Text(responseDetalle['Data'][0]['UpdatedAt'])
                          ],)),
                        ],
                      ),

                      const SizedBox(height: 15,),

                      ExpansionTile(
                        textColor: Colors.black,
                        iconColor: Colors.black,
                        leading: const Icon(Icons.work),
                        title: Text('Empleado'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('N-IMSS: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['N-Imss']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('Nombre: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['Nombre']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('Apellido Paterno: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['Apellido-Paterno']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('Apellido Materno: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['Apellido-Materno']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('RFC: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['Rfc']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('CURP: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['Curp']),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('Fecha de nacimiento: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Empleado']['Fecha-Nacimiento']),
                              ],
                            ),
                          ),
                      ]),

                      ExpansionTile(
                        textColor: Colors.black,
                        iconColor: Colors.black,
                        leading: const Icon(Icons.person),
                        title: Text('Proveedor'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('Raz-N-Social: ', style: TextStyle(fontSize: 16),),
                                Expanded(child: Text(responseDetalle['Data'][0]['Generales-Proveedor']['Raz-N-Social'], overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                const Text('RFC: ', style: TextStyle(fontSize: 16),),
                                Text(responseDetalle['Data'][0]['Generales-Proveedor']['Rfc']),
                              ],
                            ),
                          ),
                      ]),

                      ExpansionTile(
                        textColor: Colors.black,
                        iconColor: Colors.black,
                        leading: const Icon(Icons.folder),
                        title: Text('Archivos'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                // const Text('N-IMSS: ', style: TextStyle(fontSize: 16),),
                                Expanded(child: Text(responseDetalle['Data'][0]['Generales-Archivos']['Archivo 1'])),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                // const Text('N-IMSS: ', style: TextStyle(fontSize: 16),),
                                Expanded(child: Text(responseDetalle['Data'][0]['Generales-Archivos']['Archivo 1'])),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                // const Text('N-IMSS: ', style: TextStyle(fontSize: 16),),
                                Expanded(child: Text(responseDetalle['Data'][0]['Generales-Archivos']['Archivo 1'])),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padTop, bottom: padBottom),
                            child: Row(
                              children: [
                                // const Text('N-IMSS: ', style: TextStyle(fontSize: 16),),
                                Expanded(child: Text(responseDetalle['Data'][0]['Generales-Archivos']['Archivo 1'])),
                              ],
                            ),
                          ),
                      ]),

                      const SizedBox(height: 15,),

                      GestureDetector(
                        onTap: () async {

                          try {

                            if(imageSelected){
                             print('Guardar');
                            } else {
                              await _initializeControllerFuture;

                              image = await _controller.takePicture();

                              setState(() {
                                imageSelected = !(imageSelected);
                              });
                            }
                            // await Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => DisplayPictureScreen(
                            //       imagePath: image.path,
                            //     ),
                            //   ),
                            // );
                          } catch (e) {
                            print(e);
                          }

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          padding: const EdgeInsets.only(bottom: 10, top: 10,left: 25, right: 15),
                          child: Center(child: Text(
                            imageSelected ?
                            'Guardar' : 'Tomar foto',
                            style: const TextStyle(color: Colors.white),)),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if(imageSelected){
                              return Image.file(File(image.path));
                            } else {
                              return CameraPreview(_controller);
                            }
                          } else {
                            return Image.network('http://generator.1qr.fr/?id=3sUU0&size=7&date=202202&cache=1');
                          }
                        },
                      ),

                      // SizedBox(
                      //   width: 150,
                      //   height: 150,
                      //   child: imageSelected ? Image.network('http://generator.1qr.fr/?id=3sUU0&size=7&date=202202&cache=1') : Image.network('http://generator.1qr.fr/?id=3sUU0&size=7&date=202202&cache=1'),
                      // )

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _status(String index){

    double iconSize = 70.0;

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

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}