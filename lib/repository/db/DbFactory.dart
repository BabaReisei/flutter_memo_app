import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../names/MemoNames.dart';

abstract class DbFactory {
  Database db;
  /**
   * DBインスタンス生成
   * @param sql create tableのSQL
   * @return Databaseインスタンス
   */
  Future<Database> dbOpen(String sql, String dbFileName) async {

    // DBアクセスのディレクトリパスの取得
    var databasesPath = await getDatabasesPath();

    // DBアクセスのファイルパスを設定する
    final path = join(databasesPath, dbFileName);

    // Databaseインスタンスを返却する
    db = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          sql,
        );
        },
      version: 1,
    );
    return db;
  }

  // 登録処理
  Future<void> save(var something);

  // 取得処理
  Future <dynamic> get(int id);

  // 全取得処理
  Future <List<dynamic>> getAll();

  // 更新処理
  Future<void> update(var something);

  // 削除処理
  Future<void> delete(int id);
}
