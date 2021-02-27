import 'package:flutter/material.dart';

class StaticListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Viewwww'),
      ),
      body: getDynamicListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add post",
        onPressed: () => debugPrint('Y click fab'),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    var snackBar = SnackBar(
      content: Text('u idiot'),
      action: SnackBarAction(
          label: "OK", onPressed: () => debugPrint('y u click action')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  List<String> getItems() {
    return List<String>.generate(1000, (index) => "Item $index");
  }

  Widget getDynamicListView() {
    var items = getItems();
    var listView = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text(items[index]),
            onTap: () {
              debugPrint('u tapped on item $index');
              showSnackBar(context);
            },
          );
        });
    return listView;
  }

  Widget getStaticListView() {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.landscape),
          title: Text('Landscape'),
          subtitle: Text('This is a landscape'),
          trailing: Icon(Icons.wb_sunny),
          onTap: () => onTap(),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        )
      ],
    );
  }

  void onTap() {
    debugPrint('u tapped on stupid landscape');
  }
}
