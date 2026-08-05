import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const EPSApp());
}

class EPSApp extends StatelessWidget {
  const EPSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eps-Topik Nepali Book',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeDashboardView(),
    const LeaderboardScreen(),
    const UBTExamScreen(),
    const BooksScreen(),
    const NoticeBoardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/logo.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.school, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'EPS-TOPIK Nepali Book',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'UBT Exam'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notice'),
        ],
      ),
    );
  }
}

// ================= 1. HOME DASHBOARD VIEW =================
class HomeDashboardView extends StatelessWidget {
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blue, Colors.indigo]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Student', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    Text('EPS-TOPIK Nepal', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Main Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryBtn(context, Icons.menu_book, 'Books', Colors.orange, const BooksScreen()),
              _buildCategoryBtn(context, Icons.translate, 'Vocabulary', Colors.pink, const VocabularyScreen()),
              _buildCategoryBtn(context, Icons.spellcheck, 'Grammar', Colors.purple, const GrammarScreen()),
              _buildCategoryBtn(context, Icons.style, 'Flash Card', Colors.teal, const FlashCardScreen()),
            ],
          ),
          const SizedBox(height: 24),

          // Exam Section
          const Text('📝 Exam & Practice', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(16)),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1,
              children: [
                _buildGridTile(context, Icons.computer, 'UBT-EXAM', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UBTExamScreen()));
                }),
                _buildGridTile(context, Icons.quiz, 'Word Quiz', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WordQuizScreen()));
                }),
                _buildGridTile(context, Icons.forum, 'Dialogue Practice', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DialogueScreen()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildCategoryBtn(BuildContext context, IconData icon, String title, Color color, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Column(
        children: [
          CircleAvatar(radius: 26, backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color, size: 28)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _buildGridTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 22, backgroundColor: Colors.white, child: Icon(icon, color: Colors.blueAccent, size: 24)),
          const SizedBox(height: 6),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ================= 2. VOCABULARY SCREEN =================
class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  final List<Map<String, String>> words = const [
    {"kr": "한국 (Hanguk)", "np": "कोरिया (Korea)"},
    {"kr": "선생님 (Seonsaengnim)", "np": "शिक्षक (Teacher)"},
    {"kr": "학생 (Hakseang)", "np": "विद्यार्थी (Student)"},
    {"kr": "회사원 (Hoesawon)", "np": "कम्पनी कर्मचारी (Company Worker)"},
    {"kr": "의사 (Uisa)", "np": "डाक्टर (Doctor)"},
    {"kr": "경찰관 (Gyeongchalgwan)", "np": "प्रहरी (Police)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Korean Vocabulary (शब्दार्थ)')),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(words[index]['kr']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(words[index]['np']!, style: const TextStyle(fontSize: 16, color: Colors.blueGrey)),
            ),
          );
        },
      ),
    );
  }
}

// ================= 3. GRAMMAR SCREEN =================
class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

  final List<Map<String, String>> grammars = const [
    {"title": "입니다 / 입니까?", "desc": "हो / हो? (Is / Are / Am)", "eg": "저는 학생입니다. (म विद्यार्थी हुँ।)"},
    {"title": "이/가", "desc": "कर्ता कारक (Subject Particle)", "eg": "가방이 있습니다. (झोला छ।)"},
    {"title": "을/를", "desc": "कर्म कारक (Object Particle)", "eg": "밥을 먹습니다. (भात खान्छु।)"},
    {"title": "에 / 에서", "desc": "मा / बाट (In, At, To / From)", "eg": "학교에 갑니다. (स्कूल जान्छु।)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EPS Grammar (व्याकरण)')),
      body: ListView.builder(
        itemCount: grammars.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(grammars[index]['title']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  const SizedBox(height: 5),
                  Text("अर्थ: ${grammars[index]['desc']!}", style: const TextStyle(fontSize: 16)),
                  const Divider(),
                  Text("उदाहरण: ${grammars[index]['eg']!}", style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= 4. FLASH CARD SCREEN =================
class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  int _currentIndex = 0;
  bool _showMeaning = false;

  final List<Map<String, String>> cards = const [
    {"kr": "가방", "np": "झोला (Bag)"},
    {"kr": "책", "np": "किताब (Book)"},
    {"kr": "시계", "np": "घडी (Clock)"},
    {"kr": "의자", "np": "कुर्सी (Chair)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flash Cards')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() => _showMeaning = !_showMeaning),
              child: Container(
                width: 280,
                height: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.amber, width: 2)),
                child: Text(
                  _showMeaning ? cards[_currentIndex]['np']! : cards[_currentIndex]['kr']!,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("अर्थ हेर्न कार्डमा थिच्नुहोस् (Tap to see meaning)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0 ? () => setState(() { _currentIndex--; _showMeaning = false; }) : null,
                  child: const Text('अघिल्लो (Prev)'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _currentIndex < cards.length - 1 ? () => setState(() { _currentIndex++; _showMeaning = false; }) : null,
                  child: const Text('पछिल्लो (Next)'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ================= 5. BOOKS SCREEN =================
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EPS TOPIK Textbooks')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildBookTile('Book 1 (Chapter 1 - 30)', 'मूलभूत कोरियाली भाषा पाठ्यपुस्तक - १'),
          _buildBookTile('Book 2 (Chapter 31 - 60)', 'उन्नत कोरियाली भाषा पाठ्यपुस्तक - २'),
        ],
      ),
    );
  }

  Widget _buildBookTile(String title, String sub) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.blue, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

// ================= 6. UBT EXAM SCREEN =================
class UBTExamScreen extends StatefulWidget {
  const UBTExamScreen({super.key});

  @override
  State<UBTExamScreen> createState() => _UBTExamScreenState();
}

class _UBTExamScreenState extends State<UBTExamScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "다음 그림을 보고 맞는 단어를 고르십시오.",
      "options": ["1. 의자입니다.", "2. 가방입니다.", "3. 안경입니다.", "4. 책상입니다."],
      "correct": 1
    },
    {
      "question": "가: 식당이 어디에 있어요?\n나: 건물 ________에 있어요.",
      "options": ["1. 위", "2. 지하", "3. 앞", "4. 옆"],
      "correct": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('EPS UBT Exam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('प्रश्नोत्तर ${_currentQuestionIndex + 1}/${_questions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(currentQ['question'], style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currentQ['options'].length,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    title: Text(currentQ['options'][index]),
                    value: index,
                    groupValue: _userAnswers[_currentQuestionIndex],
                    onChanged: (val) {
                      setState(() { _userAnswers[_currentQuestionIndex] = val!; });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentQuestionIndex < _questions.length - 1) {
                  setState(() => _currentQuestionIndex++);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam Submit भयो!')));
                }
              },
              child: Text(_currentQuestionIndex == _questions.length - 1 ? 'Submit' : 'Next'),
            )
          ],
        ),
      ),
    );
  }
}

// ================= OTHER SCREENS =================
class WordQuizScreen extends StatelessWidget {
  const WordQuizScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Word Quiz')), body: const Center(child: Text('Quiz system ready!')));
}

class DialogueScreen extends StatelessWidget {
  const DialogueScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Dialogue Practice')), body: const Center(child: Text('대화 (Dialogue) Section')));
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Leaderboard')), body: const Center(child: Text('🏆 Top Ranking Students')));
}

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Notice Board')), body: const Center(child: Text('🔔 No new notice available.')));
}
