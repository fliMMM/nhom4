import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class SingleChat{
  final String time;
  final String sender;
  final String message;
  SingleChat({required this.time,required this.sender,required this.message});
  factory SingleChat.fromJson(Map<String,dynamic> json){
    return SingleChat(
      time:json['time'].toString(),
      sender:json['sender'].toString(),
      message:json['message'].toString()
    );
  }
}

class Data {
  final String stuff;
  final List<SingleChat> messageData;
  Data({required this.stuff,required this.messageData});
  factory Data.fromJson(Map<String,dynamic> parsedJson) {
    return Data(
      stuff: parsedJson['stuff'].toString(),
      messageData: parsedJson["data"]
    );
  }
}



