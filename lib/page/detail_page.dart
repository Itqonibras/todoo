import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoo/widget/delete_dialog.dart';
import '../common/input_decoration_theme.dart';
import '../data/model/task_model.dart';
import '../util/task_icon_class.dart';
import '../util/task_icon_list.dart';
import 'add_update_page.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final Task task;

  const DetailPage({super.key, required this.task});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Task _currentTask;

  @override
  void initState() {
    super.initState();
    _currentTask = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    TaskIcon icon = iconList[_currentTask.icon];
    DateTime? date = DateTime.tryParse(_currentTask.date);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Detail',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            // Task title
            const Text(
              'Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              enabled: false,
              decoration: commonInputDecoration.copyWith(
                hintText: _currentTask.title,
                hintStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            // Task desc
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              enabled: false,
              maxLines: 5,
              decoration: commonInputDecoration.copyWith(
                hintText: _currentTask.description,
                hintStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              enabled: false,
              decoration: commonInputDecoration.copyWith(
                hintText: '${date!.day}/${date.month}/${date.year}',
                hintStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Icon',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: icon.color,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              height: 50,
              width: 50,
              child: Icon(icon.icon, color: Colors.white),
            ),
            const Spacer(),
            // Add button
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Edit Button
                        final updatedTask = await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: AddUpdatePage(task: widget.task),
                          ),
                        );
                        if (updatedTask != null) {
                          setState(() {
                            _currentTask = updatedTask;
                          });
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF5038BC),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog(id: widget.task.id!);
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.redAccent, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Icon(
                      Icons.delete_sharp,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
