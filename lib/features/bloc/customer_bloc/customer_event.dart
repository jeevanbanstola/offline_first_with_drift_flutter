abstract class CustomerEvent {}

class LoadCustomers extends CustomerEvent {}

class AddCustomer extends CustomerEvent {
  final String name;
  final String phone;

  AddCustomer(this.name, this.phone);
}

class DeleteCustomer extends CustomerEvent {
  final String id;

  DeleteCustomer(this.id);
}