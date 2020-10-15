import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memo_app/repository/db/MemoDao.dart';

class TopPage extends StatelessWidget {

  /** 画面タイトル*/
  final String title;

  /** コンストラクタ */
  TopPage({Key key, this.title}) : super(key: key);

  /**
   * ウィジェットの生成
   * @param context ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.greenAccent,
            title: Text(
              '一覧',
              style:  TextStyle(
                color: Colors.black,
              ),
            ),
          ),
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

  Future<List<Widget>> _getData(BuildContext context) async {
    var titles = <Widget>[];
    MemoDao memoDao = MemoDao();
    int dataNum = 0;
    List<Memo> memos = await memoDao.getAll();
    // ListViewの作成
    if (memos != null) {
      dataNum = memos.length;
      for (Memo memo in memos) {
        titles.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/detail', arguments: memo);
            },
            child:Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
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
                      Navigator.of(context).pushNamed('/top');
                    },
                  ),
                ],
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
        onTap: () {
          Navigator.of(context).pushNamed(
              '/registration', arguments: dataNum);
        },
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
    return titles;
  }
}
