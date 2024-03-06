import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../data/model/task_model.dart';
import '../page/detail_page.dart';
import '../provider/database_provider.dart';
import '../util/task_icon_class.dart';
import '../util/task_icon_list.dart';

class CustomListTile extends StatelessWidget {
  final Task task;

  const CustomListTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    TaskIcon icon = iconList[task.icon];
    DateTime? date = DateTime.tryParse(task.date);
    IconData trailingIcon = Icons.circle_outlined;
    Color trailingIconColor = Colors.grey;
    if (task.isDone == 1) {
      trailingIcon = Icons.check_circle_sharp;
      trailingIconColor = Colors.green;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: DetailPage(task: task),
          ),
        );
      },
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFE6E6E6), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(task.title),
        subtitle: Text('${date!.day}/${date.month}/${date.year}'),
        leading: Container(
          decoration: BoxDecoration(
            color: icon.color,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          height: 50,
          width: 50,
          child: Icon(icon.icon, color: Colors.white),
        ),
        trailing: InkWell(
          onTap: () {
            Provider.of<DbProvider>(context, listen: false)
                .toggleTaskDoneStatus(task.id!);
          },
          child: Icon(trailingIcon, color: trailingIconColor),
        ),
      ),
    );
  }
}
