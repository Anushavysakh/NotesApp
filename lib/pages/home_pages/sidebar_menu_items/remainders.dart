import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';
import 'package:timezone/standalone.dart';




import '../../../model/note.dart';

class Remainder extends StatefulWidget {
  final Note? note;

  const Remainder({super.key, this.note});
  @override
  _RemainderState createState() => _RemainderState();
}

class _RemainderState extends State<Remainder> {

  double? _height;
  double? _width;

  String? _hour, _minute, _time;
  DateTime? dateTime1;
  String? dateTime;
  FlutterLocalNotificationsPlugin? localNotification;
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  // The device's timezone.


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = ('${_hour!} : ${_minute!}');
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        dateTime1 = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute);
      });
    }
  }

  @override
  void initState() {


    var androidInitialize = AndroidInitializationSettings("app_icon");
    var initializationSettings =
    InitializationSettings(android: androidInitialize);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification?.initialize(
      initializationSettings,
    );

    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime
            .now()
            .hour, DateTime
            .now()
            .minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text(
                  'Choose Date',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width! / 1.7,
                    height: _height! / 9,
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (val) {},
                      decoration: const InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Choose Time',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
            ),
            InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: _width! / 1.7,
                height: _height! / 9,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: TextFormField(
                  style: const TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                  onSaved: (val) {},
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _timeController,
                  decoration: const InputDecoration(
                      disabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                      // labelText: 'Time',
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (dateTime1 != null) {
            /*  log(dateTime1.toString());*/
            _showNotification(dateTime1!);
            scheduleNotification(selectedTime);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _showNotification(DateTime dateTime) async {
    var androidDetails = const AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      playSound: true,
      importance: Importance.high,
      priority:
      Priority.high, /* sound: RawResourceAndroidNotificationSound("sms")*/
    );
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails);
    await localNotification?.show(
        0, 'title', 'body', generalNotificationDetails);

    // ignore: deprecated_member_use
    localNotification!.schedule(
        1, 'TimeUp', "$dateTime", dateTime, generalNotificationDetails);
  }

  void scheduleNotification(TimeOfDay scheduleAlarmDateTime) async {
    scheduleAlarmDateTime = selectedTime;
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Note_notify',
      'Note_notify',
      channelDescription: 'Channel for note notification',
      icon: 'app_icon.png',
      /*sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),*/
      largeIcon: DrawableResourceAndroidBitmap('app_icon.png'),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    try {
      await localNotification?.zonedSchedule(0, 'Office', 'good morning',
          tz.TZDateTime.from(selectedDate, tz.local), platformChannelSpecifics,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
          androidAllowWhileIdle: true);
    } catch (e) {
      print(e);
    }
  }

}
