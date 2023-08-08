import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cards/card_page.dart';
import 'globals/user_model.dart';
import 'cards/boards.dart';

late User currentUs = new User(success: false);
late bool resBool = false;

fetchApi() async {
  final response = await http.get(Uri.parse('https://statemachineapidev.azurewebsites.net/api/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Error al cargar la información de la API');
  }
}

Future<User> fetchUser(String user, String password) async {
  final response = await http.post(Uri.parse('https://statemachineapidev.azurewebsites.net/api/auth/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'UserName': 'e.velazquez',
      'Password': '20Emlgris'
      // 'UserName': user,
      // 'Password': password
    }),
  );

  if (response.statusCode == 200) {

    currentUs = User.fromJson(jsonDecode(response.body));
    resBool = true;
    responseGlobal = response.body;
    responsePrincipal = {
      "Success": true,
      "Message": "La busqueda ha sido realizada de manera exitosa",
      "Data": [
        {
          "Identity": "1",
          "Name": "Visita: Arturo Pérez Navarro",
          "Status": "In progress",
          "type":"single",
          "CreatedAt": "2021-09-23T19:51:53.903Z",
          "UpdatedAt": "2021-09-23T19:51:53.903Z",
          "Active": true,
        },
        {
          "Identity": "2",
          "Name": "Visita: Wendy gonzalez",
          "Status": "In progress",
          "type":"single",
          "CreatedAt": "2021-09-23T19:51:53.903Z",
          "UpdatedAt": "2021-09-23T19:51:53.903Z",
          "Active": true,
        },
        {
          "Identity": "3",
          "Name": "Visita: Emmanuel Velazquez",
          "Status": "In progress",
          "type":"single",
          "CreatedAt": "2021-09-23T19:51:53.903Z",
          "UpdatedAt": "2021-09-23T19:51:53.903Z",
          "Active": true,
        },
        {
          "Identity": "4",
          "Name": "Visita: Erwin Oviedo",
          "Status": "In progress",
          "type":"single",
          "CreatedAt": "2021-09-23T19:51:53.903Z",
          "UpdatedAt": "2021-09-23T19:51:53.903Z",
          "Active": true,
        },
      ]
      };

    responseDetalle = {
      "Success": true,
      "Message": "La busqueda ha sido realizada de manera exitosa",
      "Data": [
        {
        "Identity": "1",
        "Name": "Solicitud",
        "Status": "In progress",
        "type":"single",
        "CreatedAt": "2021-09-23T19:51:53.903Z",
        "UpdatedAt": "2021-09-23T19:51:53.903Z",
        "Active": true,
        "Generales-Empleado":{
          "N-Imss":"123",
          "Nombre":"Emmanuel",
          "Apellido-Paterno":"Velazquez",
          "Apellido-Materno":"Cano",
          "Rfc":"VECG861212",
          "Curp":"VECG861212",
          "Fecha-Nacimiento":"12/12/1986"
        },
        "Generales-Proveedor":{
          "Raz-N-Social":"Servicios Industriales SA de CV",
          "Rfc":"SERIND"
        },
        "Generales-Archivos":{
          "Archivo 1": "http://flowstatemachineapp.com/uploads/ ...",
          "Archivo 2": "http://flowstatemachineapp.com/uploads/ ...",
          "Archivo 3": "http://flowstatemachineapp.com/uploads/ ...",
          "Archivo 4": "http://flowstatemachineapp.com/uploads/ ..."
        }
      }
    ]};

    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  camera = firstCamera;

  runApp(
    MyApp()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future futureApi;
  late Future<User> futureUser;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late FocusNode userFN = FocusNode();
  late FocusNode passFN = FocusNode();

  @override
  void initState() {
    super.initState();
    futureApi = fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    const color = const Color(0xFFecf1f8);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color,
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: futureApi,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              return Stack(
                children: [

                  Container(
                      decoration: const BoxDecoration(
                         color: color,
                          )
                  ),

                  Center(
                    child: Container(
                        margin: const EdgeInsets.all(10.0),
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                const SizedBox(height: 20.0,),
                                Text(
                                  'Inicio de sesión',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                const SizedBox(height: 15.0,),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    controller: _userController,
                                    focusNode: userFN,
                                    autofocus: false,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.multiline,
                                    style: Theme.of(context).textTheme.headline6,
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
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
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0,),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    focusNode: passFN,
                                    autofocus: false,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.multiline,
                                    style: Theme.of(context).textTheme.headline6,
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
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
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0,),
                                GestureDetector(
                                  onTap: () async {

                                    futureUser = fetchUser(_userController.text,
                                        _passwordController.text);

                                    futureUser.whenComplete(() {
                                      if(resBool) {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return Boards(currentUs);
                                            }));
                                      } else {
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text('Usuario o contraseña incorrecto'),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    });

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    padding: const EdgeInsets.only(bottom: 10, top: 10,left: 25, right: 15),
                                    child: const Center(child: Text('Ingresar', style: TextStyle(color: Colors.white),)),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )
                    ),
                  ),

                ],
              );
            }
            else if (snapshot.hasError) {
              return Stack(
                children: [

                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/backgrounds/back-5.jpg"),
                              fit: BoxFit.cover))
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${snapshot.error}'),

                          ],
                        )
                    ),
                  ),

                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}