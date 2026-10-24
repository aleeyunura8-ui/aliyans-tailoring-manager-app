
import 'package:flutter/material.dart';

void main() => runApp(const AliyansApp());

const green = Color(0xFF005A3C);
const darkGreen = Color(0xFF003B2A);
const gold = Color(0xFFE7B936);
const bg = Color(0xFFF4F7F6);

class AliyansApp extends StatelessWidget {
  const AliyansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aliyans Tailoring Manager',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        appBarTheme: const AppBarTheme(
          backgroundColor: green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedTab = 0;

  final sections = const [
    ('Customers', 'View & Manage', Icons.groups, Colors.green),
    ('Groups', 'View & Manage', Icons.group_work, gold),
    ('Orders', 'All Orders', Icons.assignment, Colors.blue),
    ('Measurements', '7 Standard Sizes', Icons.straighten, Colors.purple),
    ('Payments', 'Record & Track', Icons.account_balance_wallet, Colors.red),
    ('Receipts', 'Generate & Share', Icons.receipt_long, Colors.green),
    ('Deliveries', 'Track Deliveries', Icons.local_shipping, Colors.orange),
    ('Reports', 'Business Reports', Icons.bar_chart, Colors.blue),
    ('Settings', 'App Preferences', Icons.settings, Colors.blueGrey),
  ];

  void openSection(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SectionPage(title: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: header()),
            SliverToBoxAdapter(child: statistics()),
            SliverToBoxAdapter(child: quickActions()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = sections[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => openSection(item.$1),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.black12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.$3, size: 35, color: item.$4),
                            const SizedBox(height: 9),
                            FittedBox(
                              child: Text(
                                item.$1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FittedBox(
                              child: Text(
                                item.$2,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: sections.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.88,
                ),
              ),
            ),
            SliverToBoxAdapter(child: contactCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkGreen,
        selectedItemColor: gold,
        unselectedItemColor: Colors.white70,
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() => selectedTab = index);
          if (index != 0) {
            const names = ['Home', 'Customers', 'Groups', 'Orders', 'More'];
            openSection(names[index]);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.group_work), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'More'),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 28, 18, 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [darkGreen, green, Color(0xFF08764E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const Icon(Icons.design_services, color: gold, size: 55),
          const SizedBox(height: 8),
          const Text(
            'ALIYANS STYLE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: gold,
              fontSize: 27,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const Text(
            'TAILORING CENTER',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Jega, Kebbi State, Nigeria',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'TAILORING MANAGER',
              style: TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statistics() {
    final stats = [
      ('Customers', '0', Icons.person, Colors.green),
      ('Groups', '0', Icons.groups, gold),
      ('Total Orders', '0', Icons.assignment, Colors.blue),
      ('Total Revenue', '₦0', Icons.database, Colors.purple),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      child: Row(
        children: stats.map((s) {
          return Expanded(
            child: Container(
              height: 112,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(s.$3, color: s.$4, size: 27),
                  const SizedBox(height: 7),
                  FittedBox(
                    child: Text(s.$1, style: const TextStyle(fontSize: 10)),
                  ),
                  const SizedBox(height: 5),
                  FittedBox(
                    child: Text(
                      s.$2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget quickActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: actionButton(
              'Add Customer',
              'Individual Measurements',
              Icons.person_add,
              green,
              Colors.white,
              () => openSection('Add Customer'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: actionButton(
              'Add Group',
              'Multiple People',
              Icons.group_add,
              gold,
              darkGreen,
              () => openSection('Add Group'),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Color textColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 112,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: gold, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 30),
            const SizedBox(height: 6),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                subtitle,
                style: TextStyle(color: textColor, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: ListTile(
        tileColor: const Color(0xFFDDF3E8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFB7DECB)),
        ),
        leading: const Icon(Icons.chat, color: green, size: 36),
        title: const Text(
          'Contact Customer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Send Updates via WhatsApp'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => openSection('Contact Customer'),
      ),
    );
  }
}

class SectionPage extends StatelessWidget {
  final String title;

  const SectionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.construction, size: 65, color: green),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This section is being prepared. Customer records, '
                'measurements, orders and payments will be added step by step.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
