import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro_timer/utils/time_constants_utils.dart';

class TimeAdjustDialog extends StatefulWidget {
  final String title;
  final int initialTime;
  final ValueChanged<int> onConfirm;

  const TimeAdjustDialog({
    super.key,
    required this.title,
    required this.initialTime,
    required this.onConfirm,
  });

  @override
  State<TimeAdjustDialog> createState() => _TimeAdjustDialogState();
}

class _TimeAdjustDialogState extends State<TimeAdjustDialog> {
  late int tempTime;

  void initState() {
    super.initState();
    tempTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.5),
      insetPadding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if (tempTime > TimeConstants.minTime)
                      setState(() => tempTime -= TimeConstants.step);
                  },
                  child: SvgPicture.asset('assets/icons/remove.svg', width: 40, height: 40),
                ),
                SizedBox(width: 30),
                Text('$tempTime',
                  style: TextStyle(fontSize: 100, color: Colors.white),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: (){
                    if(tempTime < TimeConstants.maxTime)
                      setState(() => tempTime += TimeConstants.step);
                  },
                  child: SvgPicture.asset('assets/icons/add.svg', width: 40, height: 40),
                )
              ],
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: (){
                widget.onConfirm(tempTime);
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/icons/check.svg', width: 40, height: 40),
            )
          ],
        ),
      ),
    );
  }
}
