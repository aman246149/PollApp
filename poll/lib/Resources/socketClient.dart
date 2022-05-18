import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClent {
  static SocketClent? _instace;
  IO.Socket? socket;

  SocketClent._internal() {
    socket = IO.io("http://192.168.1.4:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();
  }

  static SocketClent get instance {
    _instace ??= SocketClent._internal();
    return _instace!;
  }
}
