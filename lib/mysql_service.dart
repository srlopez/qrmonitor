import 'package:mysql_client/mysql_client.dart';
import 'package:tuple/tuple.dart';

import 'app_storage.dart';

class Mysql {
  final store = AppStorage();

  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
        host: store.host,
        port: store.port,
        userName: store.user,
        password: store.password,
        databaseName: store.database,
        secure: false);
    await conn.connect();
    return conn;
  }

  Future<Map<String, Tuple2<String, String>>> readQRData(String qrCode) async {
    Map<String, Tuple2<String, String>> map = {};
    try {
      var conn = await getConnection();
      //centreon_storage.hosts.name
      var result = await conn.execute("""select 
      services.description, 
      services.output,
      services.last_hard_state,
      hosts.address
      FROM services, hosts 
      WHERE services.host_id = hosts.host_id 
      AND (from_unixtime(services.last_check) >= NOW() - INTERVAL 1 WEEK) 
      AND hosts.name = :qrcode
      ORDER BY services.description ASC, 
      services.last_check DESC""", {"qrcode": qrCode});

      for (final row in result.rows) {
        // print(row.colAt(0));
        // print(row.colByName("title"));

        // print all rows as Map<String, String>
        // print(row.assoc());
        map['Dirección IP'] = Tuple2('${row.colAt(3)}', "0");
        map['${row.colAt(0)}'] = Tuple2('${row.colAt(1)}', '${row.colAt(2)}');
      }
      //map = result.rows.first.assoc();
      conn.close();
    } catch (e) {
      map = {'ERROR': Tuple2(e.toString(), '2')}; //2 COlor ROJO
    }

    return Future(() {
      return map;
    });
  }
}
