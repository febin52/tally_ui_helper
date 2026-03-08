class Company {
  final String guid;
  final String name;
  final String address;
  final String state;
  final String country;
  final String email;
  final String booksFrom;

  Company({
    required this.guid,
    required this.name,
    required this.address,
    required this.state,
    required this.country,
    required this.email,
    required this.booksFrom,
  });

  factory Company.fromXmlMap(Map<String, String> map) {
    return Company(
      guid: map['GUID'] ?? '',
      name: map['NAME'] ?? map['COMPANYNAME'] ?? '',
      address: map['ADDRESS'] ?? '',
      state: map['STATENAME'] ?? '',
      country: map['COUNTRYNAME'] ?? '',
      email: map['EMAIL'] ?? '',
      booksFrom: map['BOOKSFROM'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'guid': guid,
        'name': name,
        'address': address,
        'state': state,
        'country': country,
        'email': email,
        'booksFrom': booksFrom,
      };
}
