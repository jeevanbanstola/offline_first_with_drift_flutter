import 'package:drift/drift.dart';

class Customers extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get phone => text().nullable()();

  BoolColumn get isDeleted =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get action => text()();

  TextColumn get recordId => text()();

  TextColumn get payload => text()();

  BoolColumn get synced =>
      boolean().withDefault(const Constant(false))();
}