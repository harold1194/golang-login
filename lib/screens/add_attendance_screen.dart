import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:golang_login/models/attendance.dart';
import 'package:golang_login/widgets/my_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../commin_widgets/my_text_field.dart';

class AddAttendanceScreen extends StatefulWidget {
  const AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  var optionYear = ['1st year', ' 2nd year', '3rd year', '4th year'];
  var currentYearSelected = '1st year';
  var year = '1st year';

  var optionDegree = ['BSIS', 'BSAIS', 'BSA', 'BSE', 'BSTM'];
  var currentDegreeSelected = 'BSIS';
  var degree = 'BSIS';

  var optionBlock = ['Block 1', 'Block 2', 'Block 3', 'Block 4'];
  var currentBlockSelected = 'Block 1';
  var block = 'Block 1';

  DateTime currentdate = DateTime.now();
  static var startTime = TimeOfDay.now();
  var endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);

  _showdatepicker() async {
    var selecteddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2299),
            currentDate: DateTime.now())
        .then((value) {
      setState(() {
        currentdate = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fullnameController = TextEditingController();
    addressController = TextEditingController();
    subjectController = TextEditingController();

    currentdate = DateTime.now();
    endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
  }

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    addressController.dispose();
    subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Attendance", isAutoImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  icon: Icons.person,
                  hint: 'Juan Dela Cruz',
                  validator: (value) {
                    return value!.isEmpty ? "Please enter your name" : null;
                  },
                  textEditingController: fullnameController,
                  showicon: false,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Course',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      items: optionDegree.map((String dropDownStringCourse) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringCourse,
                          child: Text(
                            dropDownStringCourse,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          currentDegreeSelected = newValueSelected!;
                          degree = newValueSelected;
                        });
                      },
                      value: currentDegreeSelected,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Year',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      items: optionYear.map((String dropDownStringBlock) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringBlock,
                          child: Text(
                            dropDownStringBlock,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          currentYearSelected = newValueSelected!;
                          year = newValueSelected;
                        });
                      },
                      value: currentYearSelected,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Block',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      items: optionBlock.map((String dropDownStringBlock) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringBlock,
                          child: Text(
                            dropDownStringBlock,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          currentBlockSelected = newValueSelected!;
                          block = newValueSelected;
                        });
                      },
                      value: currentBlockSelected,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Subject',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  icon: Icons.person,
                  hint: 'Programming 2',
                  validator: (value) {
                    return value!.isEmpty ? "Please enter your name" : null;
                  },
                  textEditingController: subjectController,
                  showicon: false,
                ),
                const SizedBox(height: 10),
                Text(
                  'Date',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  showicon: false,
                  icon: Icons.calendar_today,
                  hint: DateFormat('dd/MM/yyyy').format(currentdate),
                  readonly: true,
                  validator: (value) {
                    return null;
                  },
                  textEditingController: TextEditingController(),
                  ontap: () {
                    _showdatepicker();
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Time',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      icon: Icons.watch,
                      showicon: false,
                      readonly: true,
                      hint: DateFormat('HH:mm a').format(
                          DateTime(0, 0, 0, startTime.hour, startTime.minute)),
                      validator: (value) {
                        return null;
                      },
                      textEditingController: TextEditingController(),
                      ontap: () {
                        Navigator.push(
                          context,
                          showPicker(
                            value: Time(
                              hour: startTime.hour + 1,
                              minute: startTime.minute,
                            ),
                            is24HrFormat: true,
                            minHour: startTime.hour.toDouble() - 1,
                            accentColor: Colors.deepPurple,
                            onChange: (TimeOfDay newvalue) {
                              setState(() {
                                startTime = newvalue;
                                endTime = TimeOfDay(
                                    hour: startTime.hour < 22
                                        ? startTime.hour + 1
                                        : startTime.hour,
                                    minute: startTime.minute);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Text(
                      'End Time',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      icon: Icons.watch,
                      showicon: false,
                      readonly: true,
                      hint: DateFormat('HH:mm a').format(
                          DateTime(0, 0, 0, endTime.hour, endTime.minute)),
                      validator: (value) {
                        return null;
                      },
                      textEditingController: TextEditingController(),
                      ontap: () {
                        Navigator.push(
                          context,
                          showPicker(
                            value: Time(
                              hour: startTime.hour,
                              minute: startTime.minute,
                            ),
                            is24HrFormat: true,
                            minHour: startTime.hour.toDouble() - 1,
                            accentColor: Colors.deepPurple,
                            onChange: (TimeOfDay newvalue) {
                              setState(() {
                                endTime = newvalue;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(onPressed: _saveAttendance, child: Text("save"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveAttendance() {
    if (formKey.currentState!.validate()) {
      // Perform your saving logic here
      // Get the values from the text fields and other input widgets
      final newAttendance = Attendance(
        fullname: fullnameController.text,
        address: addressController.text,
        degree: degree,
        year: year,
        block: block,
        subject: subjectController.text,
        date: DateFormat('yyyy-MM-dd').format(currentdate),
        startTime: startTime.format(context),
        endTime: endTime.format(context),
      );
      // ... extract other relevant data

      final String url = 'http://10.0.2.2:8080/api/create_attendance';

      http.post(Uri.parse(url), body: {
        'fullname': newAttendance.fullname,
        'address': newAttendance.address,
        'degree': newAttendance.degree,
        'year': newAttendance.year,
        'block': newAttendance.block,
        'subject': newAttendance.subject,
        'date': DateFormat('yyyy-MM-dd').format(currentdate),
        'startTime': startTime.format(context),
        'endTime': endTime.format(context),
      }).then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student data saved successfully!')),
          );
        } else {
          throw Exception('Failed to save data');
        }
      }).catchError((error) {
        print(error);
      });
    }
  }
}
