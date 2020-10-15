import 'package:flutter/material.dart';
import 'package:memo_app/repository/db/MemoDao.dart';

class Detail extends StatelessWidget{

  /** タイトル */
  final String title;

  /** 画面タイトル */
  static const appBarTitle = "メモ本文表示";

  /** コンストラクタ */
  Detail({Key key, this.title}): super(key: key);

  /**
   * ウィジェットの生成
   * @param context ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {

    // データの引継ぎ
    final Memo args = ModalRoute.of(context).settings.arguments;

    // 画面サイズ測定
    final Size size = MediaQuery.of(context).size;

    // コントローラのインスタンス生成
    final titleController = TextEditingController(text:args.toMap()['title']);
    final textController = TextEditingController(text:args.toMap()['text']);

    MemoDao memoDao = new MemoDao();

    // メモ詳細表示ウィジェットを呼び出し元へ返却
    return MaterialApp(
      home: Scaffold(

        // アプリバー
        appBar: AppBar(
          leading:Container(

            // 戻るボタンの追加
            alignment: FractionalOffset.centerLeft,
            child: OverflowBox(
              maxWidth: 100.0,
              child: FlatButton(
                onPressed: (){
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

          // 画面タイトル表示
          centerTitle: true,
          backgroundColor: Colors.lightGreenAccent,
          title: new Text(
            appBarTitle,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),

        // メイン部
        body: Column(
          children: <Widget>[

            // タイトル部
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

            // 本文部
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/update', arguments: args);
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