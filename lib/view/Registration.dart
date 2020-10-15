import 'package:flutter/material.dart';
import 'package:memo_app/repository/db/MemoDao.dart';

class Registration extends StatelessWidget{

  /** タイトル */
  final String title;

  /** 画面タイトル */
  static const appBarTitle = "メモ新規登録";

  // コントローラのインスタンス生成
  final titleController = TextEditingController();
  final textController = TextEditingController();

  /** コンストラクタ */
  Registration({Key key, this.title}): super(key: key);

  /**
   * ウィジェットの生成
   * @param context ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {

    // データの引継ぎ
    final int args = ModalRoute.of(context).settings.arguments;

    // 画面サイズ取得
    final Size size = MediaQuery.of(context).size;

    MemoDao memoDao = new MemoDao();

    // 新規登録ウィジェットを呼び出し元へ返却
    return MaterialApp(
      home: Scaffold(

        // キーボード表示時の画面サイズ変更
        resizeToAvoidBottomInset: false,

        // アプリバー
        appBar: AppBar(
          leading:Container(
            alignment: FractionalOffset.centerLeft,

            // 戻るボタンの追加
            child: OverflowBox(
              maxWidth: 100.0,
              child: FlatButton(
                onPressed: (){
                  String trimTitle = titleController.text.trimRight();
                  String trimText = textController.text.trimRight();

                  // 未入力の場合DBへの登録は無し。
                  if (trimTitle.length != 0 || trimText.length != 0) {

                    // タイトル未入力、かつ、本文が10文字以上の場合、本文の最初から10文字をタイトルとする。
                    if (trimTitle.length == 0 && trimText.length > 10) {
                      memoDao.save(
                          Memo(
                            title: trimText.substring(0, 10),
                            text: trimText,
                            priority: args + 1,
                          )
                      );
                    }

                    // 上記以外のタイトル未入力時は本文をタイトルとする。
                    else if (trimTitle.length == 0) {
                      memoDao.save(
                          Memo(
                            title: trimText,
                            text: trimText,
                            priority: args + 1,
                          )
                      );
                    }

                    // タイトル入力がある場合はタイトルをそのまま使用する。
                    else {
                      memoDao.save(
                          Memo(
                            title: trimTitle,
                            text: trimText,
                            priority: args + 1,
                          )
                      );
                    }
                  }
                  Navigator.of(context).pushReplacementNamed('/top');
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

          // 画面タイトルの表示
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

            // メモのタイトル部
            Container(
              child:TextField(
                autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: ' タイトル'
                ),
              ),
            ),

            // メモの本文部
            GestureDetector(
              onTap: () {
                FocusScope.of(context).nextFocus();
              },
              child: Container(
                height: size.height - 132.0,
                child:TextField(
                  autofocus: true,
                  controller: textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' 本文'
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