import 'package:flutter/cupertino.dart';
import 'package:poll/Resources/socketClient.dart';
import 'package:poll/provider/pollsProvider.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClent.instance.socket!;

  //emits

  void createRoom(String question, List pollsQuestion) {
    if (question.isNotEmpty) {
      _socketClient.emit("createRoom", {
        "question": question,
        "pollsQuestion": pollsQuestion,
      });
    }
  }

  void checkBoxPressedUpdateData(String uid, String dataName, int index) {
    print(dataName);
    if (uid.isNotEmpty ||
        dataName.isNotEmpty ||
        index != null ||
        dataName.isNotEmpty) {
      print(index);
      _socketClient.emit(
          "updateCheckBoxData", {"uid": uid, "data": dataName, "index": index});
    }
  }

  //listner

  void createRoomSuccessListner(BuildContext context) {
    print("DATA FROM CREATE ROOM");
    _socketClient.on("createRoomSuccess", (data) {
      print(data);

      Provider.of<PollsProvider>(context, listen: false).updateList(data);
    });
  }

  void callDatainitStateListeners(BuildContext context) {
    _socketClient.on("initstate", (data) {
      print(data);
      Provider.of<PollsProvider>(context, listen: false).updateList(data);
    });
  }

  void updateListListner(BuildContext context) {
    print("updatelistenre call");
    _socketClient.on("updateListListner", (data) {
      print("data from server $data");
      Provider.of<PollsProvider>(context, listen: false).updateList(data);
    });
  }
}
