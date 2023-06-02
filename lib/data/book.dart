class Book_Model {
  String? datetimeStart;
  String? datetimeEnd;

  Book_Model({this.datetimeStart, this.datetimeEnd});

  Book_Model.fromJson(Map<String, dynamic> json) {
    datetimeStart = json['datetime_start'];
    datetimeEnd = json['datetime_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime_start'] = this.datetimeStart;
    data['datetime_end'] = this.datetimeEnd;
    return data;
  }
}
