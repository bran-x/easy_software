class User extends Object {
  final String id;
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String? address;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.address,
  });
}
