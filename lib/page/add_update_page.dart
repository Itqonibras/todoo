import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoo/common/input_decoration_theme.dart';
import 'package:todoo/provider/database_provider.dart';
import '../data/model/task_model.dart';
import '../util/task_icon_class.dart';
import '../util/task_icon_list.dart';

class AddUpdatePage extends StatefulWidget {
  static const routeName = '/addUpdate';

  final Task? task;

  const AddUpdatePage({super.key, this.task});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  DateTime _date = DateTime.now();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isUpdate = false;
  int _currentIconIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _currentIconIndex = widget.task!.icon;
      _date = DateTime.tryParse(widget.task!.date)!;
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isUpdate ? 'Update Task' : 'Add New Task',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            // Task title
            const Text(
              'Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: commonInputDecoration,
            ),
            const SizedBox(height: 8),
            // Task desc
            const Text(
              'Description (not required)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 5,
              controller: _descriptionController,
              decoration: commonInputDecoration,
            ),
            const SizedBox(height: 8),
            const Text(
              'Select Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: commonInputDecoration.copyWith(
                        hintText: '${_date.day}/${_date.month}/${_date.year}'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xFF5038BC),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        );
                        if (dateTime != null) {
                          setState(() {
                            _date = dateTime;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.date_range_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Select Icon',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 6,
              shrinkWrap: true,
              crossAxisSpacing: 8,
              children: iconList.asMap().entries.map((entry) {
                int index = entry.key;
                TaskIcon icon = entry.value;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _currentIconIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: (index == _currentIconIndex)
                          ? icon.color
                          : icon.color.withOpacity(0.5),
                    ),
                    child: Icon(icon.icon, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            // Add button
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  // Submit Button
                  if (_titleController.text.isNotEmpty) {
                    if (!_isUpdate) {
                      final newTask = Task(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        icon: _currentIconIndex,
                        date: _date.toString(),
                        isDone: 0,
                      );
                      Provider.of<DbProvider>(context, listen: false)
                          .addTask(newTask);
                      Navigator.pop(context);
                    } else {
                      final newTask = Task(
                        id: widget.task!.id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        icon: _currentIconIndex,
                        date: _date.toString(),
                        isDone: widget.task!.isDone,
                      );
                        Provider.of<DbProvider>(context, listen: false)
                            .updateTask(newTask);
                      Navigator.pop(context, newTask);
                    }
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          content: Text(
                              _isUpdate ? 'Task updated!' : 'Task created!'),
                        ),
                      );
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          margin: EdgeInsets.fromLTRB(12, 0, 12, 100),
                          backgroundColor: Color(0xFFFFDCE0),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          content: Text(
                            "Task title can't be empty!",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF5038BC),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: Text(
                  _isUpdate ? 'Update' : 'Add Task',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
