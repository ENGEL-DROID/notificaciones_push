import 'package:flutter/material.dart';
import 'package:notificaciones_push/screens/home_screen.dart';
import 'package:notificaciones_push/screens/message_screen.dart';
import 'package:notificaciones_push/services/push_notification_services.dart';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;

void main() async {
  //
  // Inicializar Firebase:
  // TODO: integrar firebase para desktop y web
  // Ejecutar sólo si es android o ios:
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await PushNotificationServices.initializeApp();
  }

  // Inicializar la aplicación:
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // se crean instancias para manejar los keys:
  // tipo Navigator:
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // tipo Scaffold:
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  //
  // se inicia el Stream del Push Notification:
  @override
  void initState() {
    super.initState();
    // se llama al getter del Stream:
    PushNotificationServices.messageStream.listen((message) {
      print('MyApp: $message');
      //
      // al recibir la notificación push la app va directo a la screen asignada:
      navigatorKey.currentState?.pushNamed('/message', arguments: message);
      //
      // se crea una ventana emergente o toast:
      final snackBar = SnackBar(
        content: Text(message),
      );
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/message': (context) => const MessageScreen(),
        // '/page2': (context) => Page2(),
      },
      // se agregan keys para utilizar el contexto con los push notifications:
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: messengerKey, // Snacks
    );
  }
}
