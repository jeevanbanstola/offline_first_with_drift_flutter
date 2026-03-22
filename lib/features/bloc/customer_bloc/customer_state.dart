import '../../../core/database/app_database.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;

  CustomerLoaded(this.customers);
}