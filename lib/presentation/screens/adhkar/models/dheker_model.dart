import 'package:drift/drift.dart';

class Adhkar extends Table {
  IntColumn get id => integer().autoIncrement()(); // ID يتم توليده تلقائيًا
  TextColumn get category => text()();
  TextColumn get count => text()();
  TextColumn get description => text()();
  TextColumn get reference => text()();
  TextColumn get zekr => text()();
}

// class Dhekr {
//   final int? id;
//   final String category;
//   final String count;
//   final String description;
//   final String reference;
//   final String zekr;
//
//   Dhekr({
//     this.id,
//     required this.category,
//     required this.count,
//     required this.description,
//     required this.reference,
//     required this.zekr,
//   });
//
//   factory Dhekr.fromJson(Map<String, dynamic> json) {
//     return Dhekr(
//       id: json['id'],
//       category: json['category'],
//       count: json['count'],
//       description: json['description'],
//       reference: json['reference'],
//       zekr: json['zekr'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'category': category,
//       'count': count,
//       'description': description,
//       'reference': reference,
//       'zekr': zekr,
//     };
//   }
// }
