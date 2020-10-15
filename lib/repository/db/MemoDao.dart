import 'package:memo_app/repository/names/MemoNames.dart';
import 'package:sqflite/sqflite.dart';

import 'DbFactory.dart';

class MemoDao extends DbFactory {

  //コンストラクタ
  MemoDao() {}

  /**
   * Database 接続処理
   * <ul>
   *   <li>DBとの接続</li>
   *   <li>テーブル生成</li>
   *   <li>  ※テーブルが存在しない場合</li>
   * </ul>
   * @return DBインスタンスをFuture型で返却
   */
  Future<Database> connectDb() async {

    // DB接続済みのインスタンスを呼び出し元へ返却
    return await dbOpen(
        MemoNames().CREATE_TABLE_MEMO,
        MemoNames().DB_FILE_NAME
    );
  }

  /**
   * メモの登録処理
   * <ul>
   *   <li>新規メモをDBへ登録</li>
   * </ul>
   * @param memo 新規メモ
   */
  @override
  Future<void> save(var memo) async {

    // DB接続
    Database db = await connectDb();

    // 登録処理を行う
    await db.insert(
      'memo',
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // DB切断
    db.close();
  }

  /**
   * メモの取得処理（未使用）
   * <ul>
   *   <li>DBからメモを取得</li>
   *   <li>取得したメモはListに格納される</li>
   * </ul>
   * @param id 取得するレコードのID（primary key）
   * @return 取得したメモのリストをFuture型で返却
   */
  @override
  Future <Memo> get(int id) async {

    // DB接続
    Database db = await connectDb();

    // メモをMapで取得
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from memo where id = $id");

    // 取得したメモのMapをVO型へ変換し呼び出し元へ返却
    return Memo(
        id: maps[0]['id'],
        title: maps[0]['title'],
        text: maps[0]['text'],
        priority: maps[0]['priority'],
      );
  }

  /**
   * メモの取得処理
   * <ul>
   *   <li>DBからメモを取得</li>
   *   <li>取得したメモはListに格納される</li>
   * </ul>
   * @return 取得したメモのリストをFuture型で返却
   */
  @override
  Future <List<Memo>> getAll() async {

    // DB接続
    Database db = await connectDb();

    // メモをMapのListで取得
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from memo order by priority");

    // 取得したメモのMapをVO型へ変換し呼び出し元へ返却
    List<Memo> memos = List.generate(maps.length, (i) {
        return Memo(
          id: maps[i]['id'],
          title: maps[i]['title'],
          text: maps[i]['text'],
          priority: maps[i]['priority'],
        );
      });
    return memos;
  }

  // メモの更新
  @override
  Future<void> update(var memo) async {
    Database db = await connectDb();
    await db.update(
      'memo',
      memo.toMap(),
      where: "id = ?",
      whereArgs: [memo.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  // メモの削除
  @override
  Future<void> delete(int id) async {
    Database db = await connectDb();
    await db.delete(
      'memo',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

/** Mapper */
class Memo {
  final int id;
  final String title;
  final String text;
  final int priority;

  Memo({this.id, this.title, this.text, this.priority});

  // Mapへ設定する
  Map <String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'priority': priority,
    };
  }
}