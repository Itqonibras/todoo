import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoo/provider/database_provider.dart';
import '../common/input_decoration_theme.dart';
import '../widget/custom_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<DbProvider>(context, listen: false).searchResultClear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Provider.of<DbProvider>(context, listen: false)
                  .searchResultClear();
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: commonInputDecoration.copyWith(
                  hintText: 'Type to search',
                  prefixIcon: const Icon(Icons.search_sharp),
                ),
                onChanged: (query) {
                  Provider.of<DbProvider>(context, listen: false)
                      .updateSearchQuery(query);
                  Provider.of<DbProvider>(context, listen: false).search(query);
                },
              ),
              const SizedBox(height: 8),
              Consumer<DbProvider>(
                builder: (context, provider, child) {
                  final result = provider.searchResult;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: result.length,
                          itemBuilder: (context, index) {
                            return CustomListTile(task: result[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
