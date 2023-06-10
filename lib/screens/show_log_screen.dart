import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golang_login/models/attendance.dart';
import 'package:golang_login/widgets/my_app_bar.dart';
import 'package:http/http.dart' as http;

class ShowLogScreen extends StatefulWidget {
  const ShowLogScreen({super.key});

  @override
  State<ShowLogScreen> createState() => _ShowLogScreenState();
}

class _ShowLogScreenState extends State<ShowLogScreen> {
  List<Attendance> attendances = [];

  // get attendance
  Future getAttendane() async {
    var response = await http.get(Uri.http('10.0.2.2:8080', '/api/attendance'));
    print(response.body);
    var jsonData = jsonDecode(response.body);

    for (var eachAttendance in jsonData['data']) {
      final attendance = Attendance(
        fullname: eachAttendance['fullname'],
        address: eachAttendance['address'],
        degree: eachAttendance['degree'],
        year: eachAttendance['year'],
        block: eachAttendance['block'],
        subject: eachAttendance['subject'],
        date: eachAttendance['date'],
        startTime: eachAttendance['startTime'],
        endTime: eachAttendance['endTime'],
      );
      attendances.add(attendance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Show Log', isAutoImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: getAttendane(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: attendances.map((attendance) {
                    return Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            const Text('Full Name: '),
                            Text(attendance.fullname),
                          ],
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Text('Degree'),
                                Text(attendance.degree),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('year'),
                                Text(attendance.year),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Block'),
                                Text(attendance.block),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
