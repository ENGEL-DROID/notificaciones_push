import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;

  // Declarar e instanciar el Stream de tipo String que se emite cuando se recibe una notificación push:
  static final StreamController<String>? _messageStream =
      StreamController<String>.broadcast();

  // definir un método para cerrar el StreamController aunque no se usa nunca:
  static closeStreams() {
    _messageStream?.close();
  }

  // getter del Stream:
  static Stream<String> get messageStream => _messageStream!.stream;

  // se crea el método para iniciar Firebase:
  static Future initializeApp() async {
    // Inicializar Firebase:
    await Firebase.initializeApp();
    // Obtener el token:
    token = await FirebaseMessaging.instance.getToken();
    // Imprimir token en consola:
    print(token);

    // Configurar notificaciones:
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  //
  // se crean los métodos para gestionar el mensaje:
  //
  static Future _onBackgroundHandler(RemoteMessage message) async {
    // print('on Background Handler: ${message.messageId} ');
    //
    // Montar el mensaje recibido en el Stream según curso de flutter:
    // _messageStream?.add(message.notification?.title ?? 'No hay mensaje');
    // según Pipe:
    cargarStream(message);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('on Message Handler: ${message.messageId} ');
    //
    // Montar el mensaje recibido en el Stream según curso de flutter:
    // _messageStream?.add(message.notification?.title ?? 'No hay mensaje');
    // según Pipe:
    cargarStream(message);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('on Message Open App: ${message.messageId} ');
    //
    // Montar el mensaje recibido en el Stream según curso de flutter:
    // _messageStream?.add(message.notification?.title ?? 'No hay mensaje');
    // según Pipe:
    cargarStream(message);
  }

  static void cargarStream(RemoteMessage message) {
    print(message.data);
    // _messageStream?.add(message.notification?.title ?? 'No hay mensaje');
    _messageStream?.add(message.data['product'] ?? 'No hay data');
  }
}
