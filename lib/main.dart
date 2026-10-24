import 'package:flutter/material.dart';

void main() {
runApp(const AliyansApp());
}

const Color emerald = Color(0xFF006B4F);
const Color darkGreen = Color(0xFF003D2E);
const Color gold = Color(0xFFE8B83F);
const Color pageBackground = Color(0xFFF5F7F6);

class AliyansApp extends StatelessWidget {
const AliyansApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Aliyans Tailoring Manager',
theme: ThemeData(
useMaterial3: true,
scaffoldBackgroundColor: pageBackground,
colorScheme: ColorScheme.fromSeed(seedColor: emerald),
appBarTheme: const AppBarTheme(
backgroundColor: darkGreen,
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

final List<Map<String, dynamic>> sections = [
{'title': 'Customers', 'subtitle': 'View & Manage', 'icon': Icons.people_alt, 'color': Colors.green},
{'title': 'Groups', 'subtitle': 'View & Manage', 'icon': Icons.groups, 'color': gold},
{'title': 'Orders', 'subtitle': 'All Orders', 'icon': Icons.assignment, 'color': Colors.blue},
{'title': 'Measurements', 'subtitle': '7 Standard Sizes', 'icon': Icons.straighten, 'color': Colors.purple},
{'title': 'Payments', 'subtitle': 'Record & Track', 'icon': Icons.account_balance_wallet, 'color': Colors.red},
{'title': 'Receipts', 'subtitle': 'Generate & Share', 'icon': Icons.receipt_long, 'color': Colors.green},
{'title': 'Deliveries', 'subtitle': 'Track Deliveries', 'icon': Icons.local_shipping, 'color': Colors.orange},
{'title': 'Reports', 'subtitle': 'Business Reports', 'icon': Icons.bar_chart, 'color': Colors.blue},
{'title': 'Settings', 'subtitle': 'App Preferences', 'icon': Icons.settings, 'color': Colors.blueGrey},
];

void openSection(String title) {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => SectionPage(title: title),
),
);
}

Widget summaryCard(String title, String value, IconData icon, Color color) {
return Expanded(
child: Container(
margin: const EdgeInsets.all(4),
padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(14),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.05),
blurRadius: 8,
offset: const Offset(0, 3),
),
],
),
child: Column(
children: [
Icon(icon, color: color, size: 27),
const SizedBox(height: 8),
Text(title, textAlign: TextAlign.center,
style: const TextStyle(fontSize: 11)),
const SizedBox(height: 5),
Text(value,
style: const TextStyle(
fontSize: 17, fontWeight: FontWeight.bold)),
],
),
),
);
}

Widget quickAction(String title, String subtitle, IconData icon,
Color background, String destination) {
return Expanded(
child: InkWell(
onTap: () => openSection(destination),
borderRadius: BorderRadius.circular(16),
child: Container(
margin: const EdgeInsets.all(4),
padding: const EdgeInsets.all(12),
height: 95,
decoration: BoxDecoration(
color: background,
borderRadius: BorderRadius.circular(16),
border: Border.all(color: gold.withValues(alpha: 0.65)),
),
child: Row(
children: [
Icon(icon, color: Colors.white, size: 30),
const SizedBox(width: 9),
Expanded(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(title,
style: const TextStyle(
color: Colors.white,
fontSize: 14,
fontWeight: FontWeight.bold)),
const SizedBox(height: 5),
Text(subtitle,
style: const TextStyle(
color: Colors.white70, fontSize: 10)),
],
),
),
const Icon(Icons.chevron_right, color: Colors.white),
],
),
),
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
toolbarHeight: 72,
title: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('ALIYANS STYLE',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 19,
letterSpacing: 1)),
Text('TAILORING CENTER • JEGA',
style: TextStyle(fontSize: 11, color: gold)),
],
),
actions: [
IconButton(
onPressed: () => openSection('Notifications'),
icon: const Icon(Icons.notifications_none, size: 27),
),
const SizedBox(width: 5),
],
),
body: SafeArea(
child: ListView(
padding: const EdgeInsets.all(12),
children: [
Container(
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [darkGreen, emerald],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(18),
),
child: const Row(
children: [
CircleAvatar(
radius: 32,
backgroundColor: gold,
child: Icon(Icons.checkroom,
size: 37, color: darkGreen),
),
SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('ALIYANS STYLE',
style: TextStyle(
color: gold,
fontSize: 20,
fontWeight: FontWeight.bold)),
Text('TAILORING CENTER',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold)),
SizedBox(height: 5),
Text('Jega, Kebbi State, Nigeria',
style: TextStyle(
color: Colors.white70, fontSize: 12)),
],
),
),
],
),
),
const SizedBox(height: 16),
const Text('Business Overview',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: darkGreen)),
const SizedBox(height: 8),
Row(
children: [
summaryCard('Customers', '0', Icons.person, Colors.green),
summaryCard('Groups', '0', Icons.groups, gold),
],
),
Row(
children: [
summaryCard('Total Orders', '0', Icons.assignment, Colors.blue),
summaryCard('Total Revenue', '₦0', Icons.payments, Colors.purple),
],
),
const SizedBox(height: 16),
const Text('Quick Actions',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: darkGreen)),
const SizedBox(height: 6),
Row(
children: [
quickAction('Add Customer', 'Individual details',
Icons.person_add_alt_1, emerald, 'Add Customer'),
quickAction('Add Group', 'Multiple people',
Icons.group_add, const Color(0xFFB68A17), 'Add Group'),
],
),
const SizedBox(height: 18),
const Text('Manage Your Business',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: darkGreen)),
const SizedBox(height: 10),
GridView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
itemCount: sections.length,
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
mainAxisSpacing: 10,
crossAxisSpacing: 10,
childAspectRatio: 1.75,
),
itemBuilder: (context, index) {
final item = sections[index];
return InkWell(
onTap: () => openSection(item['title'] as String),
borderRadius: BorderRadius.circular(15),
child: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(15),
border: Border.all(color: Colors.grey.shade200),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.035),
blurRadius: 6,
offset: const Offset(0, 2),
),
],
),
child: Row(
children: [
Icon(item['icon'] as IconData,
color: item['color'] as Color, size: 29),
const SizedBox(width: 10),
Expanded(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(item['title'] as String,
style: const TextStyle(
fontSize: 13,
fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
Text(item['subtitle'] as String,
style: TextStyle(
fontSize: 10,
color: Colors.grey.shade600)),
],
),
),
],
),
),
);
},
),
const SizedBox(height: 16),
InkWell(
onTap: () => openSection('Contact Customer'),
child: Container(
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
color: const Color(0xFFDFF2E8),
borderRadius: BorderRadius.circular(15),
),
child: const Row(
children: [
Icon(Icons.chat, color: emerald, size: 32),
SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Contact Customer',
style: TextStyle(
fontWeight: FontWeight.bold, fontSize: 15)),
Text('Updates and WhatsApp sharing',
style: TextStyle(fontSize: 11)),
],
),
),
Icon(Icons.chevron_right),
],
),
),
),
const SizedBox(height: 18),
const Center(
child: Text(
'ALIYANS STYLE TAILORING CENTER • JEGA',
style: TextStyle(
fontSize: 10,
color: Colors.grey,
letterSpacing: 0.5),
),
),
],
),
),
bottomNavigationBar: BottomNavigationBar(
currentIndex: selectedTab,
type: BottomNavigationBarType.fixed,
backgroundColor: darkGreen,
selectedItemColor: gold,
unselectedItemColor: Colors.white70,
onTap: (index) {
setState(() => selectedTab = index);
if (index != 0) {
final destinations = [
'Home',
'Customers',
'Groups',
'Orders',
'More',
];
openSection(destinations[index]);
}
},
items: const [
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Customers'),
BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Groups'),
BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Orders'),
BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'More'),
],
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
appBar: AppBar(
title: Text(title),
leading: IconButton(
icon: const Icon(Icons.arrow_back),
onPressed: () => Navigator.pop(context),
),
),
body: Center(
child: Padding(
padding: const EdgeInsets.all(24),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(Icons.construction, size: 65, color: emerald),
const SizedBox(height: 18),
Text(title,
style: const TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: darkGreen)),
const SizedBox(height: 10),
const Text(
'This section is being prepared for Aliyans Tailoring Manager.',
textAlign: TextAlign.center,
style: TextStyle(fontSize: 15),
),
],
),
),
),
);
}
}
