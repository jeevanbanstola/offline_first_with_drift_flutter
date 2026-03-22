import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_with_drift/features/repository/customer_repository.dart';

import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository repository;

  StreamSubscription? sub;

  CustomerBloc(this.repository) : super(CustomerInitial()) {
    on<LoadCustomers>(_load);

    on<AddCustomer>(_add);

    on<DeleteCustomer>(_delete);
  }

  void _load(
    LoadCustomers event,
    Emitter<CustomerState> emit,
  ) {
    sub?.cancel();

    sub = repository.watchCustomers().listen((customers) {
      emit(CustomerLoaded(customers));
    });
  }

  Future<void> _add(
    AddCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    await repository.addCustomer(event.name, event.phone);
  }

  Future<void> _delete(
    DeleteCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    await repository.deleteCustomer(event.id);
  }
}