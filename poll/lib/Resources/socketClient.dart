import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClent {
  static SocketClent? _instace;
  IO.Socket? socket;

  SocketClent._internal() {
    socket = IO.io("https://pollappaman.herokuapp.com", <String, dynamic>{
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
