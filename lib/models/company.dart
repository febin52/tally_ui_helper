/// Represents a Tally ERP Company
class Company {
  /// Unique identifier of the company
  final String guid;

  /// Name of the company
  final String name;

  /// Address of the company
  final String address;

  /// State of the company
  final String state;

  /// Country of the company
  final String country;

  /// Email address of the company
  final String email;

  /// Books commencing from date
  final String booksFrom;

  /// Creates a [Company] instance
  Company({
    required this.guid,
    required this.name,
    required this.address,
    required this.state,
    required this.country,
    required this.email,
    required this.booksFrom,
  });

  /// Creates a [Company] from an XML map
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

  /// Converts the company into a JSON map
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
