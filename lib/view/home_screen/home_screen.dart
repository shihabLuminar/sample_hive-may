import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  final box = Hive.box("sampleBox");
  List data = [];
  List keys = [];

  @override
  void initState() {
    keys = box.keys.toList();
    data = box.values.toList();

    print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await box.clear();
                  data = box.values.toList();
                  keys = box.keys.toList();

                  setState(() {});
                },
                icon: Icon(Icons.delete_sweep))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: () async {
                  await box.add(controller.text);
                  data = box.values.toList();
                  keys = box.keys.toList();

                  setState(() {});
                  controller.clear();
                  print(box.values.toList());
                },
                child: Text("add"),
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  title: Text(data[index]),
                  trailing: IconButton(
                      onPressed: () {
                        box.delete(keys[index]);
                        data = box.values.toList();
                        keys = box.keys.toList();
                        setState(() {});
                        print(box.keys);
                        print(box.values);
                      },
                      icon: Icon(Icons.delete)),
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: data.length,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
