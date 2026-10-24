import 'package:flutter/material.dart';

void main() => runApp(const AliyansApp());

const emerald = Color(0xFF006B4F);
const gold = Color(0xFFE8B83F);

class AliyansApp extends StatelessWidget {
  const AliyansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aliyans Tailoring Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: emerald),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
      ),
      home: const CustomersPage(),
    );
  }
}

class Customer {
  String name;
  String phone;
  final Map<String, String> measurements;

  Customer({
    required this.name,
    required this.phone,
    required this.measurements,
  });
}

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final List<Customer> customers = [];

  Future<void> addCustomer() async {
    final result = await Navigator.push<Customer>(
      context,
      MaterialPageRoute(builder: (_) => const CustomerFormPage()),
    );

    if (result != null && mounted) {
      setState(() => customers.add(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: emerald,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ALIYANS STYLE'),
            Text(
              'TAILORING CENTER • JEGA',
              style: TextStyle(fontSize: 11, color: gold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customers',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Total customers: ${customers.length}'),
            const SizedBox(height: 16),
            Expanded(
              child: customers.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.people_outline, size: 64, color: emerald),
                          SizedBox(height: 12),
                          Text('No customers yet'),
                          Text('Tap the button below to add a customer.'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        final customer = customers[index];
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: emerald,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(customer.name),
                            subtitle: Text(customer.phone),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CustomerDetailsPage(customer: customer),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addCustomer,
        backgroundColor: emerald,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Customer'),
      ),
    );
  }
}

class CustomerFormPage extends StatefulWidget {
  const CustomerFormPage({super.key});

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final fields = const [
    ('Neck (Wuya)', 'neck'),
    ('Shoulder (Kafada)', 'shoulder'),
    ('Sleeve (Hannu)', 'sleeve'),
    ('Shirt Length (Tsawon Riga)', 'shirtLength'),
    ('Shirt Width (Fadin Riga)', 'shirtWidth'),
    ('Trouser Length (Tsawon Wando)', 'trouserLength'),
    ('Waist Width (Fadin Kugu)', 'waistWidth'),
  ];

  final Map<String, TextEditingController> measurementControllers = {};

  @override
  void initState() {
    super.initState();
    for (final field in fields) {
      measurementControllers[field.$2] = TextEditingController();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    for (final controller in measurementControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
        backgroundColor: emerald,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Customer Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter customer name'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Complete Set Measurements',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text('Enter measurements using your preferred unit.'),
            const SizedBox(height: 12),
            for (final field in fields) ...[
              TextFormField(
                controller: measurementControllers[field.$2],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: field.$1,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
            ],
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: emerald,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                final measurements = <String, String>{};
                for (final field in fields) {
                  measurements[field.$1] =
                      measurementControllers[field.$2]!.text.trim();
                }

                Navigator.pop(
                  context,
                  Customer(
                    name: nameController.text.trim(),
                    phone: phoneController.text.trim(),
                    measurements: measurements,
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Customer'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerDetailsPage extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: emerald,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: emerald,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                customer.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(customer.phone.isEmpty ? 'No phone number' : customer.phone),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Measurements',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final entry in customer.measurements.entries)
            Card(
              child: ListTile(
                title: Text(entry.key),
                trailing: Text(
                  entry.value.isEmpty ? 'Not entered' : entry.value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
