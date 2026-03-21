import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class CustomerRepository {
  final AppDatabase db;

  CustomerRepository(this.db);

  Stream<List<Customer>> watchCustomers() {
    return (db.select(db.customers)
          ..where((tbl) => tbl.isDeleted.equals(false)))
        .watch();
  }

  Future<void> addCustomer(String name, String phone) async {
    final id = const Uuid().v4();

    final now = DateTime.now();

    await db.into(db.customers).insert(
          CustomersCompanion.insert(
            id: id,
            name: name,
            phone: Value(phone),
            updatedAt: now,
          ),
        );

    await db.into(db.syncQueue).insert(
          SyncQueueCompanion.insert(
            name: "customers",
            action: "create",
            recordId: id,
            payload: jsonEncode({
              "id": id,
              "name": name,
              "phone": phone,
            }),
          ),
        );
  }

  Future<void> deleteCustomer(String id) async {
    await (db.update(db.customers)..where((tbl) => tbl.id.equals(id))).write(
      CustomersCompanion(
        isDeleted: const Value(true),
      ),
    );

    await db.into(db.syncQueue).insert(
          SyncQueueCompanion.insert(
            name: "customers",
            action: "delete",
            recordId: id,
            payload: jsonEncode({"id": id}),
          ),
        );
  }
}