// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PrefSlip {
  final String id_slip;
  final String id_booking;
  final String id;
  final String firstname;
  final String lastname;
  final String date;
  final String datetime_start;
  final String datetime_end;
  final String typeField;
  final String slip;
  final String price;

  PrefSlip({
    required this.id_slip,
    required this.id_booking,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.date,
    required this.datetime_start,
    required this.datetime_end,
    required this.typeField, 
    required this.slip,
    required this.price,

  });

  PrefSlip copyWith({
    String? id_slip,
    String? id_booking,
    String? id,
    String? firstname,
    String? lastname,
    String? date,
    String? datetime_start,
    String? datetime_end,
    String? typeField,
    String? slip,
    String? price,
  }) {
    return PrefSlip(
      id_slip: id_slip ?? this.id_slip,
      id_booking: id_booking ?? this.id_booking,
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      date: date ?? this.date,
      datetime_start: datetime_start ?? this.datetime_start,
      datetime_end: datetime_end ?? this.datetime_end,
      typeField: typeField ?? this.typeField,
      slip: slip ?? this.slip,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_slip': id_slip,
      'id_booking': id_booking,
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'date': date,
      'datetime_start': datetime_start,
      'datetime_end': datetime_end,
      'typeField': typeField,
      'slip': slip,
      'price': price,
    };
  }

  factory PrefSlip.fromMap(Map<String, dynamic> map) {
    return PrefSlip(
      id_slip: map['id_slip'],
      id_booking: map['id_booking'],
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      date: map['date'],
      datetime_start: map['datetime_start'],
      datetime_end: map['datetime_end'],
      typeField: map['typeField'],
      slip: map['slip'],
      price: map['price'],
      // id_booking: json['id_booking'],
      // id: json['id'],
      // firstname: json['firstname'],
      // lastname: json['lastname'],
      // datetime_start: json['datetime_start'],
      // time: json['time'],
      // typeField: json['typeField'],
      // slip: json['slip'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrefSlip.fromJson(String source) =>
      PrefSlip.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrefSlip(id_slip: $id_slip,id_booking: $id_booking, id: $id, firstname: $firstname, lastname: $lastname,, date: $date datetime_start: $datetime_start, datetime_end: $datetime_end, typeField: $typeField, slip: $slip, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrefSlip &&
        other.id_slip == id_slip &&
        other.id_booking == id_booking &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.date == date &&
        other.datetime_start == datetime_start &&
        other.datetime_end == datetime_end &&
        other.typeField == typeField &&
        other.slip == slip &&
        other.price == price;

  }

  @override
  int get hashCode {
    return 
        id_slip.hashCode ^
        id_booking.hashCode ^
        id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        date.hashCode ^
        datetime_start.hashCode ^
        datetime_end.hashCode ^
        typeField.hashCode ^
        slip.hashCode ^
        price.hashCode;
  }
}