import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  var location; //location for the UI
  var time; //the time in that locatiom
  var url; //location url for endpoint api
  var flag; //url to asset flag icon
  var isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getData() async {
    try {
      var response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      // var data = (response.body);
      //var rawJson = '{"name":"Mary","age":30}';

      Map map = jsonDecode(response.body); // import 'dart:convert';
      // print(map) ;
      var datetime = map['datetime'];
      var offset = map['utc_offset'].substring(1, 3);
     // var hours = datetime.substring(11, 14);
      //var hour1 = hours.toString();
      var now = DateTime.parse(datetime);

      now = now.add(Duration(hours: int.parse(offset)));

     isDayTime = now.hour > 6 && now.hour <19 ? true : false;
      time = DateFormat.jm().format(now);
      print(now.hour);
    } catch (e) {
      print('Caught an error $e');
      time = "could not get time";
    }
  }
}
