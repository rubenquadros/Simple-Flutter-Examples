import 'package:flutter/material.dart';

class MyStateFulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyStateFulWidget> {
  var name = '';
  var options = ['idiot', 'dumb', 'stupid'];
  var currentOption = 'idiot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful Widgets'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (String input) {
                setState(() {
                  name = input;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Dumb dumb $name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Sans',
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: DropdownButton(
                items: options
                    .map((value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.w400)),
                        ))
                    .toList(),
                onChanged: (String selectedValue) =>
                    dropDownSelected(selectedValue),
                value: currentOption,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Selected value $currentOption',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'Sans',
                      fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ),
    );
  }

  void dropDownSelected(String value) {
    setState(() {
      currentOption = value;
    });
  }
}
