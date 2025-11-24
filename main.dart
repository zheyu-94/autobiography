import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 需要在 pubspec.yaml 添加此套件

void main() {
  runApp(const MySelfIntroApp());
}

class MySelfIntroApp extends StatelessWidget {
  const MySelfIntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[50], // 背景色調淡一點
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // --- 個人資料設定區 (請在此修改你的姓名與聯絡方式) ---
  final String name = "李哲宇"; // 請填入你的名字
  final String jobTitle = "學生"; // 請填入你的職稱
  final String phoneNumber = "0987367250"; // 請填入電話
  final String email = "c112151126@nkust.edu.tw"; // 請填入 Email

  // 自傳內容
  final String section1_background =
      "我出生於一個務農的家庭，父母每天在田裡辛勤耕作，讓我從小就深刻體會到「付出才有收穫」的道理。農村生活雖然樸實，但也培養了我勤勞、踏實的性格，懂得珍惜資源並尊重自然。這樣的成長環境，讓我在面對挑戰時更能保持耐心與毅力。";

  final String section2_traits =
      "我是一個重視自我管理的人，習慣在生活中保持規律，並且勇於嘗試新事物。面對挑戰時，我不輕易退縮，而是透過不斷學習與練習來突破困難。這樣的特質也讓我在學習與工作上能持續進步。";

  final String section4_future =
      "我希望能在未來的學習與工作中，延續這些興趣所培養的特質：健身的自律、動畫的創意、釣魚的耐心。這些經驗不僅塑造了我的人格，也讓我在面對人生道路時，能以穩健的步伐持續前進。";

  // 興趣列表 (對應圖示)
  final List<Map<String, dynamic>> interests = const [
    {"name": "健身", "desc": "維持健康與體態，展現自我紀律", "icon": Icons.fitness_center},
    {"name": "看動畫", "desc": "靈感來源，帶來勇氣與啟發", "icon": Icons.movie_filter},
    {"name": "釣魚", "desc": "學會耐心與專注，享受自然", "icon": Icons.phishing}, // 需 Flutter 2.5+ 才有 phishing icon，若無可用 water_drop
  ];

  // 輔助函式：開啟連結
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('無法開啟 $url'); // 使用 debugPrint 避免 crash
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("個人自傳"),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white, // Material 3 樣式調整
        elevation: 2,
        shadowColor: Colors.black12,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // 1. 頭像與基本資料
            _buildHeader(),

            const SizedBox(height: 20),
            // 2. 聯絡方式
            _buildContactBar(),

            const SizedBox(height: 20),
            // 3. 自傳區塊
            _buildSectionTitle("一、成長背景", Icons.spa),
            _buildTextCard(section1_background),

            _buildSectionTitle("二、個人特質", Icons.psychology),
            _buildTextCard(section2_traits),

            _buildSectionTitle("三、興趣與生活", Icons.interests),
            _buildInterestsCard(),

            _buildSectionTitle("四、未來展望", Icons.rocket_launch),
            _buildTextCard(section4_future),
          ],
        ),
      ),
    );
  }

  // 區塊：頭部
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue.shade100, width: 4),
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5))
              ]
          ),
          child: const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/fishman.jpg'), // 可換成 AssetImage('assets/me.jpg')
          ),
        ),
        const SizedBox(height: 15),
        Text(
          name,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            jobTitle,
            style: TextStyle(fontSize: 16, color: Colors.blue.shade800, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  // 區塊：聯絡方式 (橫向排列)
  Widget _buildContactBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _launchUrl("tel:$phoneNumber"),
          icon: const Icon(Icons.phone, size: 18),
          label: const Text("撥打電話"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 1),
        ),
        const SizedBox(width: 15),
        ElevatedButton.icon(
          onPressed: () => _launchUrl("mailto:$email"),
          icon: const Icon(Icons.email, size: 18),
          label: const Text("寄送郵件"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 1),
        ),
      ],
    );
  }

  // 區塊：純文字卡片
  Widget _buildTextCard(String content) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 0, // 平面化設計
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200), // 加上細邊框
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
          textAlign: TextAlign.justify, // 左右對齊
        ),
      ),
    );
  }

  // 區塊：興趣專用卡片
  Widget _buildInterestsCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: interests.map((item) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'], color: Colors.orange),
              ),
              title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['desc']),
            );
          }).toList(),
        ),
      ),
    );
  }

  // 區塊：標題
  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 20, 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}