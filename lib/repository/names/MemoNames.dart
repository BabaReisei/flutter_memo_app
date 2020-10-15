class MemoNames {

  // プライベートコンストラクタ
  MemoNames _() {}

  // memoテーブルの生成
  final CREATE_TABLE_MEMO = """
      CREATE TABLE memo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      text TEXT,
      priority INTEGER)
      """;
  // database名
  final String DB_FILE_NAME = "memo.db";
}