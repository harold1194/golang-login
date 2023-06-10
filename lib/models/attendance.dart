class Attendance {
  String fullname;
  String address;
  String degree;
  String year;
  String block;
  String subject;
  String date;
  String startTime;
  String endTime;

  Attendance({
    required this.fullname,
    required this.address,
    required this.degree,
    required this.year,
    required this.block,
    required this.subject,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      fullname: json['fullname'],
      address: json['address'],
      degree: json['degree'],
      year: json['year'],
      block: json['block'],
      subject: json['subject'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}
