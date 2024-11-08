import 'package:drift/drift.dart';

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sorahName => text()();
  IntColumn get pageNum => integer()();
  TextColumn get lastRead => text()();
}

// class Bookmarks {
//   int? id;
//   String? sorahName;
//   int? pageNum;
//   String? lastRead;
//
//   Bookmarks({this.id, this.sorahName, this.pageNum, this.lastRead});
//
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'id': id,
//       'sorahName': sorahName,
//       'pageNum': pageNum,
//       'lastRead': lastRead,
//     };
//   }
//
//   Bookmarks.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sorahName = json['sorahName'];
//     pageNum = json['pageNum'];
//     lastRead = json['lastRead'];
//   }
// }
