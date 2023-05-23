import 'dart:convert';

class SQLiteModel{
  final int? id;
  final String id_booking;
  final String firstname;
  final String lastname;
  final String datetime_start;
  final String datetime_end;
  final String typeField;
  SQLiteModel({
     this.id,
    required this.id_booking,
    required this.firstname,
    required this.lastname,
    required this.datetime_start,
    required this.datetime_end,
    required this.typeField,
  });

  SQLiteModel copyWith({
    int? id,
    String? id_booking,
    String? firstname,
    String? lastname,
    String? datetime_start,
    String? datetime_end,
    String? typeField,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      id_booking: id_booking ?? this.id_booking,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      datetime_start: datetime_start ?? this.datetime_start,
      datetime_end: datetime_end ?? this.datetime_end,
      typeField: typeField ?? this.typeField,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_booking': id_booking,
      'firstname': firstname,
      'lastname': lastname,
      'datetime_start': datetime_start,
      'datetime_end': datetime_end,
      'typeField': typeField,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: map['id'],
      id_booking: map['id_booking'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      datetime_start: map['datetime_start'],
      datetime_end: map['datetime_end'],
      typeField: map['typeField'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) => SQLiteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SQLiteModel(id: $id, id_booking: $id_booking, firstname: $firstname, lastname: $lastname, datetime_start: $datetime_start, datetime_end: $datetime_end, typeField: $typeField)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SQLiteModel &&
      other.id == id &&
      other.id_booking == id_booking &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.datetime_start == datetime_start &&
      other.datetime_end == datetime_end &&
      other.typeField == typeField;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      id_booking.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      datetime_start.hashCode ^
      datetime_end.hashCode ^
      typeField.hashCode;
  }
}