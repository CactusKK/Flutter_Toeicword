import 'package:flutter/material.dart';
import 'package:toeic_words_practice/models/chapter_model.dart';
import 'package:toeic_words_practice/services/find_json.dart';
import 'package:toeic_words_practice/widgets/chapter_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<ChapterModel>> chapters = FindJson.getChapter();
  int selectedMode = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedMode = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "토익 영단어 외우기",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color(0xffF7E1AE),
        foregroundColor: const Color(0xff617A55),
        elevation: 2,
      ),
      body: FutureBuilder(
        future: chapters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xffFFF8D6),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(child: makeList(snapshot)),
                ],
              ),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xffFFF8D6),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffF7E1AE),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates_rounded),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Challenge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Word List',
          ),
        ],
        currentIndex: selectedMode, // 지정 인덱스로 이동
        selectedItemColor: const Color(0xffA4D0A4),
        onTap: _onItemTapped, // 선언했던 onItemTapped
      ),
    );
  }

  ListView makeList(snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var chapter = snapshot.data![index];
        return Chapter(
          title: chapter.title,
          selectedMode: selectedMode,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 1,
      ),
    );
  }
}
