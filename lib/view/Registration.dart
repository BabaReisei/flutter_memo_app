import 'package:flutter/material.dart';
import 'package:memo_app/repository/db/MemoDao.dart';

class Registration extends StatelessWidget{
  Registration({Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    final int args = ModalRoute.of(context).settings.arguments;
    final titleController = TextEditingController();
    final textController = TextEditingController();
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
                    memoDao.save(
                        Memo(
                          title: trimTitle,
                          text: trimText,
                          priority: args + 1,
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
            "新規登録",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child:TextField(
                autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'タイトル'
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).nextFocus();
              },
              child: Container(
                height: 300,
                child:TextField(
                  autofocus: true,
                  controller: textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '本文'
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