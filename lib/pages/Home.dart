import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:report/dbhelper.dart';
import 'package:report/pages/entryform.dart';
import 'package:report/models/item.dart';

//pendukung program asinkron
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;
  @override
  Widget build(BuildContext context) {
    updateListView();
    if (itemList == null) itemList = List<Item>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF18265),
        title: Text(
          'Report Today!',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffF18265),
        child: Text('+', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            // TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insert(item);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
      ]),
    );
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: const Color(0xff252c48),
                child: Icon(Icons.topic_outlined)),
            title: Text(
              "Code : " + this.itemList[index].code,
              style: textStyle,
            ),
            subtitle: Text(
                "Pendapatan Rp. " + this.itemList[index].pendapatan.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.delete(this.itemList[index].id);
                if (result > 0) updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              if (item != null) {
                dbHelper.update(item);
                updateListView();
              }
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}