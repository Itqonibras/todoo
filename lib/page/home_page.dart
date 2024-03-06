import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:todoo/page/add_update_page.dart';
import 'package:todoo/page/search_page.dart';
import 'package:todoo/provider/database_provider.dart';
import '../widget/custom_list_tile.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: const Color(0xFF5038BC),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'todoo.',
              style: GoogleFonts.varela(fontWeight: FontWeight.w600),
            ),
            InkWell(
              //Knp ga pake iconButton aja? iconButton ada paddingnya mls.
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const SearchPage(),
                  ),
                );
              },
              child: const Icon(Icons.search_sharp),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add task'),
        icon: const Icon(Icons.add_sharp),
        backgroundColor: const Color(0xFF5038BC),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const AddUpdatePage(),
            ),
          );
        },
      ),
      body: Consumer<DbProvider>(builder: (context, provider, child) {
        final task = provider.task;
        final taskDone = provider.taskDone;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color(0xFF5038BC),
                height: screenSize * (1 / 6),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "let's start\nplanning your life",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        'You have ${task.length} task to do!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: const Color(0xFF5038BC),
                    height: 25,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    height: 25,
                  ),
                ],
              ),
              if (task.isNotEmpty | taskDone.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  child: Text(
                    'Active Task',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              if (taskDone.isNotEmpty && task.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text("You don't have any active task"),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: task.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(task: task[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (task.isNotEmpty | taskDone.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  child: Text(
                    'Complete Task',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              if (taskDone.isEmpty && task.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text("You don't have any complete task"),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: taskDone.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(task: taskDone[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}
