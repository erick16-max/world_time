import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    //print(data);
    var bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    var bgColor = data['isDayTime'] ? Colors.blue[400] : Colors.grey[900];
    var timeColor = data['isDayTime'] ? Colors.black45: Colors.white;

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
            child: Column(
              children: [
                FlatButton.icon(
                    onPressed: () async {
                      dynamic results = await
                          Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': results['time'],
                          'location': results['location'],
                          'isDayTime': results['isDayTime'],
                          'flag': results['flag']
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(color: Colors.grey[300]),
                    )),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['location'],
                        style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: Colors.white))
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 70.0, color: timeColor),
                )
              ],
            ),
          ),
        )));
  }
}
