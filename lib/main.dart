import 'package:flutter/material.dart';

void main() {
  runApp(const EPSTopikApp());
}

class EPSTopikApp extends StatelessWidget {
  const EPSTopikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EPS-TOPIK Nepali Book',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
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
    const BookChapterListScreen(),
    const VocabularyListScreen(),
    const GrammarListScreen(),
    const UBTExamPracticeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.menu_book, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'EPS TOPIK Nepali Book',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Chapters'),
          BottomNavigationBarItem(icon: Icon(Icons.translate), label: 'Vocab'),
          BottomNavigationBarItem(icon: Icon(Icons.spellcheck), label: 'Grammar'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'UBT Exam'),
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
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.school, size: 36, color: Colors.white),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EPS-TOPIK Self Study', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      Text('नेपाली व्याख्या सहित पाठ्यपुस्तक', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text('📚 Study Sections', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
          const SizedBox(height: 10),

          // Main Action Cards
          Row(
            children: [
              _buildFeatureCard(
                context,
                title: 'Book 1 (1-30)',
                subtitle: 'भाग १ पाठ्यपुस्तक',
                icon: Icons.menu_book,
                color: Colors.orange,
                target: const BookChapterListScreen(),
              ),
              const SizedBox(width: 10),
              _buildFeatureCard(
                context,
                title: 'Book 2 (31-60)',
                subtitle: 'भाग २ पाठ्यपुस्तक',
                icon: Icons.auto_stories,
                color: Colors.teal,
                target: const BookChapterListScreen(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildFeatureCard(
                context,
                title: 'Vocabulary',
                subtitle: 'महत्वपूर्ण शब्दार्थ',
                icon: Icons.translate,
                color: Colors.pink,
                target: const VocabularyListScreen(),
              ),
              const SizedBox(width: 10),
              _buildFeatureCard(
                context,
                title: 'Grammar Rules',
                subtitle: 'व्याकरण नियम',
                icon: Icons.spellcheck,
                color: Colors.purple,
                target: const GrammarListScreen(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text('📝 Exam & Flashcards', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
          const SizedBox(height: 10),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.indigoAccent, child: Icon(Icons.style, color: Colors.white)),
              title: const Text('Flash Cards', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('शब्दार्थ सम्झिने सजिलो तरिका'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashCardScreen())),
            ),
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.computer, color: Colors.white)),
              title: const Text('UBT Model Exam', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('वास्तविक परीक्षा जस्तै अभ्यास'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UBTExamPracticeScreen())),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget target,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, spreadRadius: 1),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.15), child: Icon(icon, color: color)),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= 2. CHAPTERS LIST SCREEN =================
class BookChapterListScreen extends StatelessWidget {
  const BookChapterListScreen({super.key});

  final List<Map<String, String>> chapters = const [
    {"num": "1", "title": "안녕하세요 (नमस्कार)", "sub": "기본 인사 (साधारण अभिवादन)"},
    {"num": "2", "title": "이게 뭐예요? (यो के हो?)", "sub": "물건 (सामग्रीहरू)"},
    {"num": "3", "title": "교실 한국어 (कक्षाकोठाको कोरियाली)", "sub": "수업 (कक्षा सम्बन्धी)"},
    {"num": "4", "title": "주말 잘 보내세요 (वीकएन्ड राम्रोसँग बिताउनुहोस्)", "sub": "인사말 (अभिवादन)"},
    {"num": "5", "title": "반갑습니다 (भेटेर खुसी लाग्यो)", "sub": "자기소개 (आत्म-परिचय)"},
    {"num": "6", "title": "저는 이민우입니다 (म इ-मिन-उ हुँ)", "sub": "국적/직업 (राष्ट्रियता र पेशा)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EPS TOPIK Chapters')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final item = chapters[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(item['num']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text('과 ${item['num']}: ${item['title']!}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['sub']!),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChapterDetailScreen(chapterTitle: '과 ${item['num']}: ${item['title']!}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ChapterDetailScreen extends StatelessWidget {
  final String chapterTitle;
  const ChapterDetailScreen({super.key, required this.chapterTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(chapterTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text('📌 Dialogue 1 (बातचीत १)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
            SizedBox(height: 8),
            Card(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('가: 안녕하세요? (नमस्कार?)', style: TextStyle(fontSize: 16)),
                    Divider(),
                    Text('나: 네, 안녕하세요. (हो, नमस्कार।)', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('📖 Vocabulary (शब्दार्थ)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
            SizedBox(height: 8),
            Card(
              elevation: 1,
              child: ListTile(
                title: Text('선생님 - शिक्षक'),
                subtitle: Text('학생 - विद्यार्थी'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= 3. VOCABULARY SCREEN =================
class VocabularyListScreen extends StatelessWidget {
  const VocabularyListScreen({super.key});

  final List<Map<String, String>> vocabs = const [
    {"kr": "한국", "np": "कोरिया (Korea)"},
    {"kr": "선생님", "np": "शिक्षक (Teacher)"},
    {"kr": "학생", "np": "विद्यार्थी (Student)"},
    {"kr": "회사원", "np": "कम्पनी कर्मचारी (Office Worker)"},
    {"kr": "의사", "np": "डाक्टर (Doctor)"},
    {"kr": "경찰관", "np": "प्रहरी (Police Officer)"},
    {"kr": "요리사", "np": "भान्से (Chef)"},
    {"kr": "운전기사", "np": "चालक (Driver)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulary (शब्दार्थ)')),
      body: ListView.builder(
        itemCount: vocabs.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo[50],
                child: Text('${index + 1}', style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
              ),
              title: Text(vocabs[index]['kr']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(vocabs[index]['np']!, style: const TextStyle(fontSize: 15, color: Colors.black87)),
            ),
          );
        },
      ),
    );
  }
}

// ================= 4. GRAMMAR SCREEN =================
class GrammarListScreen extends StatelessWidget {
  const GrammarListScreen({super.key});

  final List<Map<String, String>> grammars = const [
    {
      "title": "입니다 / 입니까?",
      "meaning": "हो / हो? (Is / Are / Am)",
      "desc": "명사 뒤에 붙어서 문장의 주어를 설명할 때 사용합니다.\n(नाउनको पछाडि जोडिएर वाक्य पूरा गर्न प्रयोग गरिन्छ।)",
      "example": "저는 학생입니다. (म विद्यार्थी हुँ।)"
    },
    {
      "title": "이 / 가",
      "meaning": "ले / - (Subject Particle)",
      "desc": "문장의 주어를 나타내는 조사입니다.\n(वाक्यको कर्ता (Subject) जनाउन प्रयोग गरिन्छ।)",
      "example": "가방이 있습니다. (झोला छ।)"
    },
    {
      "title": "을 / 를",
      "meaning": "लाई (Object Particle)",
      "desc": "문장의 목적어를 나타내는 조사입니다.\n(वाक्यको कर्म (Object) जनाउन प्रयोग गरिन्छ।)",
      "example": "밥을 먹습니다. (भात खान्छु।)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Korean Grammar (व्याकरण)')),
      body: ListView.builder(
        itemCount: grammars.length,
        itemBuilder: (context, index) {
          final item = grammars[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  const SizedBox(height: 4),
                  Text("अर्थ: ${item['meaning']!}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.deepOrange)),
                  const SizedBox(height: 8),
                  Text(item['desc']!, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  const Divider(height: 20),
                  Text("उदाहरण: ${item['example']!}", style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= 5. FLASH CARDS =================
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _showMeaning ? Colors.green[50] : Colors.amber[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _showMeaning ? Colors.green : Colors.amber, width: 2),
                ),
                child: Text(
                  _showMeaning ? cards[_currentIndex]['np']! : cards[_currentIndex]['kr']!,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: _showMeaning ? Colors.green[900] : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text("अर्थ हेर्न कार्डमा थिच्नुहोस् (Tap to Flip)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0
                      ? () => setState(() {
                            _currentIndex--;
                            _showMeaning = false;
                          })
                      : null,
                  child: const Text('Previous'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _currentIndex < cards.length - 1
                      ? () => setState(() {
                            _currentIndex++;
                            _showMeaning = false;
                          })
                      : null,
                  child: const Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ================= 6. UBT EXAM PRACTICE =================
class UBTExamPracticeScreen extends StatefulWidget {
  const UBTExamPracticeScreen({super.key});

  @override
  State<UBTExamPracticeScreen> createState() => _UBTExamPracticeScreenState();
}

class _UBTExamPracticeScreenState extends State<UBTExamPracticeScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};

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
    final q = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('EPS UBT Model Exam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('प्रश्न ${_currentQuestionIndex + 1}/${_questions.length}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
         
