import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memo_app/repository/db/MemoDao.dart';

class TopPage extends StatelessWidget {

  /** タイトル*/
  final String title;

  /** 画面タイトル */
  static const appBarTitle = "メモ一覧";

  /** コンストラクタ */
  TopPage({Key key, this.title}) : super(key: key);

  /**
   * ウィジェットの生成
   * @param context ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {

    // 生成したウィジェットを呼び出し元へ返却する
    return MaterialApp(
      home: Scaffold(

        // アプリバー
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.lightGreenAccent,
          title: Text(
            appBarTitle,
            style:  TextStyle(
              color: Colors.black,
            ),
          ),
        ),

        // メイン部
        body: FutureBuilder(
            future: _getData(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView (
                  children: snapshot.data,
                );
              } else {
                return ListView (
                  children: [],
                );
              }
            }
            ),
      ),
    );
  }

  /**
   * メモ一覧のウィジェット生成処理
   *
   * @param context ビルドコンテキスト
   * @return ウィジェット（Future型）
   */
  Future<List<Widget>> _getData(BuildContext context) async {

    // 初期化
    List<Widget> titles = <Widget>[];
    int dataNum = 0;

    // メモデータの取得
    MemoDao memoDao = MemoDao();
    List<Memo> memos = await memoDao.getAll();

    // ウィジェットの作成
    if (memos != null) {
      dataNum = memos.length;
      for (Memo memo in memos) {
        titles.add(
          GestureDetector(

            // 任意のメモタイトルとタップした場合詳細画面へ遷移する
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/detail', arguments: memo);
            },

            // メモタイトルのリストタイル生成
            child:Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),

              // スライダーを追加（削除時に使用）
              child:Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      memoDao.delete(memo.toMap()['id']);
                      Navigator.of(context).pushReplacementNamed('/top');
                    },
                  ),
                ],

                // タイトルリスト（リストタイルを使用）
                child: ListTile(
                  title: Text(
                    memo.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    // 新規登録の追加
    titles.add(
      GestureDetector(

        // 新規登録をタップした場合新規登録画面へ遷移
        onTap: () {
          Navigator.of(context).pushNamed(
              '/registration', arguments: dataNum);
        },

        // 新規登録のリストタイル生成
        child: Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              '新規登録',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );

    // 生成したウィジェットを呼び出し元へ返却
    return titles;
  }
}
