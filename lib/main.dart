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
        primarySwatch: Colors.blue,
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
    const Center(child: Text('🏆 Leaderboard', style: TextStyle(fontSize: 20))),
    const UBTExamScreen(),
    const Center(child: Text('📚 Books Section', style: TextStyle(fontSize: 20))),
    const Center(child: Text('🔔 Notice Board', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            // AppBar मा लोगो
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
              'Eps-Topik Nepali Book',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
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
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events), label: 'Leaderboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload), label: 'Ubt-Exam'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notice'),
        ],
      ),
    );
  }
}

// ---------------- HOME DASHBOARD VIEW ----------------
class HomeDashboardView extends StatelessWidget {
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD81B60),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Banner मा लोगो
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('welcome Users',
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Main Quick Access Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryIcon(
                  context, Icons.menu_book, 'Books', Colors.orange),
              _buildCategoryIcon(
                  context, Icons.folder_special, 'Resources', Colors.teal),
              _buildCategoryIcon(
                  context, Icons.font_download, 'Vocabulary', Colors.pink),
              _buildCategoryIcon(
                  context, Icons.style, 'Grammar', Colors.purple),
            ],
          ),
          const SizedBox(height: 24),

          // Exam Test Section
          const Text('📝 Exam Test',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0))),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              children: [
                _buildGridTile(context, Icons.quiz, 'Random Quiz',
                    () => _showFeatureDialog(context, 'Random Quiz')),
                _buildGridTile(context, Icons.computer, 'UBT-EXAM', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UBTExamScreen()),
                  );
                }),
                _buildGridTile(context, Icons.language, 'Web-UBT-EXAM',
                    () => _showFeatureDialog(context, 'Web-UBT-EXAM')),
                _buildGridTile(context, Icons.live_tv, 'Live Exam',
                    () => _showFeatureDialog(context, 'Live Exam')),
                _buildGridTile(context, Icons.history, 'EXAM History',
                    () => _showFeatureDialog(context, 'EXAM History')),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Others Features Section
          const Text('⭐ Others Features',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0))),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.85,
              children: [
                _buildGridTile(context, Icons.style, 'Flash Card Practice',
                    () => _showFeatureDialog(context, 'Flash Card Practice')),
                _buildGridTile(context, Icons.sort_by_alpha, 'Word Arrange',
                    () => _showFeatureDialog(context, 'Word Arrange')),
                _buildGridTile(context, Icons.headset, 'Listening Practice',
                    () => _showFeatureDialog(context, 'Listening Practice')),
                _buildGridTile(context, Icons.menu_book, 'Reading Practice',
                    () => _showFeatureDialog(context, 'Reading Practice')),
                _buildGridTile(context, Icons.edit, 'Writing Test',
                    () => _showFeatureDialog(context, 'Writing Test')),
                _buildGridTile(context, Icons.forum, 'Dialogue Test',
                    () => _showFeatureDialog(context, 'Dialogue Test')),
                _buildGridTile(context, Icons.mic, 'Speak Test',
                    () => _showFeatureDialog(context, 'Speak Test')),
                _buildGridTile(context, Icons.palette, 'Color vision Test',
                    () => _showFeatureDialog(context, 'Color vision Test')),
                _buildGridTile(context, Icons.book, 'Old Grammar',
                    () => _showFeatureDialog(context, 'Old Grammar')),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Save / Stats Section
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Vocabulary', '0', Colors.cyan[100]!),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Grammar', '0', Colors.pink[100]!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildCategoryIcon(
      BuildContext context, IconData icon, String title, Color color) {
    return GestureDetector(
      onTap: () => _showFeatureDialog(context, title),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  static Widget _buildGridTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.blueAccent, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatCard(String title, String count, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(count,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static void _showFeatureDialog(BuildContext context, String featureName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(featureName),
        content: Text('$featureName सेक्सन खोल्दैछ...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}

// ---------------- UBT EXAM SCREEN ----------------
class UBTExamScreen extends StatefulWidget {
  const UBTExamScreen({super.key});

  @override
  State<UBTExamScreen> createState() => _UBTExamScreenState();
}

class _UBTExamScreenState extends State<UBTExamScreen> {
  int _currentQuestionIndex = 0;
  int _remainingSeconds = 1200;
  Timer? _examTimer;
  final Map<int, int> _userAnswers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "다음 그림을 보고 맞는 단어나 문장을 고르십시오.",
      "image_label": "[ 가방 ]",
      "options": ["1. 의자입니다.", "2. 가방입니다.", "3. 안경입니다.", "4. 책상입니다."],
      "correct": 1
    },
    {
      "question":
          "다음 빈칸에 들어갈 가장 알맞은 것을 고르십시오.\n\n가: 식당이 어디에 있어요?\n나: 건물 ________에 있어요. 엘리베이터를 타고 내려가세요.",
      "image_label": null,
      "options": ["1. 위", "2. 지하", "3. 앞", "4. 옆"],
      "correct": 1
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _examTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _submitExam();
      }
    });
  }

  void _submitExam() {
    _examTimer?.cancel();
    int score = 0;
    _userAnswers.forEach((index, selectedOption) {
      if (_questions[index]['correct'] == selectedOption) {
        score += 5;
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('UBT Exam नतिजा'),
        content: Text('तपाईंको अंक: $score / 100'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _remainingSeconds = 1200;
                _userAnswers.clear();
              });
              _startTimer();
            },
            child: const Text('पुनः परीक्षा'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _examTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('EPS UBT Practice Exam'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Text(currentQ['question'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currentQ['options'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(currentQ['options'][index]),
                    leading: Radio<int>(
                      value: index,
                      groupValue: _userAnswers[_currentQuestionIndex],
                      onChanged: (val) {
                        setState(() {
                          _userAnswers[_currentQuestionIndex] = val!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentQuestionIndex > 0
                      ? () => setState(() => _currentQuestionIndex--)
                      : null,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentQuestionIndex < _questions.length - 1) {
                      setState(() => _currentQuestionIndex++);
                    } else {
                      _submitExam();
                    }
                  },
                  child: Text(_currentQuestionIndex == _questions.length - 1
                      ? 'Submit'
                      : 'Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
