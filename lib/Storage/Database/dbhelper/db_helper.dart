import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbHelper {
  late Database db;
  late String _path;
  final String _createUserTable = '''
                  create table chatuser ( 
                      id integer primary key autoincrement,
                      username text UNIQUE not null, 
                      name text not null
                      )
                  ''';

  final String _createGroupTable = '''
                  create table chatgroup ( 
                      id integer primary key autoincrement,
                      groupname text UNIQUE not null, 
                      name text not null
                      )
                  ''';

  final String _createMessagesTable = '''
                  create table messages ( 
                      id integer UNIQUE not null,
                      author int not null,
                      content text not null,
                      chatgroup int,
                      receiver int,
                      send_date not null,
                      receive_date text,
                      seen_date text,
                      FOREIGN KEY(author) REFERENCES chatuser(id),
                      FOREIGN KEY(receiver) REFERENCES chatuser(id),
                      FOREIGN KEY(chatgroup) REFERENCES chatgroup(id)
                      )
                  ''';

  Future open({String dbname: "kahtooMessenger.db"}) async {
    var dbpath = await getDatabasesPath();
    _path = join(dbpath, dbname);
    db = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(_createUserTable);
      await db.execute(_createGroupTable);
      await db.execute(_createMessagesTable);
    });
  }

  Future close() async {
    // db.close();
  }
}
