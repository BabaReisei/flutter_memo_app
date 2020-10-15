import 'package:flutter/material.dart';
import 'package:memo_app/repository/db/MemoDao.dart';

class Detail extends StatelessWidget{
  Detail({Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    final Memo args = ModalRoute.of(context).settings.arguments;
    final titleController = TextEditingController(text:args.toMap()['title']);
    final textController = TextEditingController(text:args.toMap()['text']);
    final Size size = MediaQuery.of(context).size;
    MemoDao memoDao = new MemoDao();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading:Container(
            alignment: FractionalOffset.centerLeft,
            child: OverflowBox(
              maxWidth: 100.0,
              child: FlatButton(
                onPressed: (){
                  String trimTitle = titleController.text.trimRight();
                  String trimText = textController.text.trimRight();
                  if (trimTitle.length != 0 || trimText.length != 0) {
                    memoDao.update(
                        Memo(
                          id: args.toMap()['id'],
                          title: trimTitle,
                          text: trimText,
                          priority: args.toMap()['priority'],
                        )
                    );
                  }
                  Navigator.of(context).pushNamed('/top');
                },
                child: Text(
                  '戻る',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: new Text(
            "詳細",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              height: 50,
              width: size.width,
              alignment: Alignment.centerLeft,
              child:Text(
                args.toMap()['title'],
                style: TextStyle(

                  fontSize: 18.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/update', arguments: args);
                print('updateへ');
              },
              child: Container(
                padding: EdgeInsets.only(top:10.0),
                alignment: Alignment.topLeft,
                height: size.height - 134.0,
                color: Colors.white,
                child: Text(
                    args.toMap()['text'],
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}