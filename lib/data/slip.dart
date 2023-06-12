class Slip_Model {
  String? idSlip;
  String? idBooking;
  String? id;
  String? firstname;
  String? lastname;
  String? date;
  String? datetimeStart;
  String? datetimeEnd;
  String? typeField;
  String? slip;
  String? price;
  String? status;

  Slip_Model(
      {this.idSlip,
      this.idBooking,
      this.id,
      this.firstname,
      this.lastname,
      this.date,
      this.datetimeStart,
      this.datetimeEnd,
      this.typeField,
      this.slip,
      this.price,
      this.status});

  Slip_Model.fromJson(Map<String, dynamic> json) {
    idSlip = json['id_slip'];
    idBooking = json['id_booking'];
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    date = json['date'];
    datetimeStart = json['datetime_start'];
    datetimeEnd = json['datetime_end'];
    typeField = json['typeField'];
    slip = json['slip'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_slip'] = this.idSlip;
    data['id_booking'] = this.idBooking;
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['date'] = this.date;
    data['datetime_start'] = this.datetimeStart;
    data['datetime_end'] = this.datetimeEnd;
    data['typeField'] = this.typeField;
    data['slip'] = this.slip;
    data['price'] = this.price;
    data['status'] = this.status;
    return data;
  }
}
