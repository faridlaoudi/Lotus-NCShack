# Lotus - Team MCoders
![alt text](https://github.com/faridlaoudi/Lotus-NCShack/blob/main/Lotus.png)

 ## 1.Overview
 Lotus is a comprehensive solution designed to optimize medication management, ensuring safety and efficiency from production to patient care. This project includes a website dashboard for pharmacies and a mobile app for patients, providing seamless integration between inventory management, patient care, and supplier coordination. Lotus leverages advanced analytics and AI to deliver real-time insights and personalized assistance, enhancing the overall healthcare experience.
   ### Real-Time Inventory Overview and Optimization:

Real-Time Inventory Overview: Displays the current stock levels of medications, automatically updating whenever a purchase is made. Includes alerts for medications nearing expiration and low stock levels.
Inventory Optimization: Utilizes ABC analysis to categorize medications based on importance and usage frequency, displays recommended safety stock levels, and monitors real-time temperature data from storage units to ensure optimal storage conditions.
### Sales and Usage Analytics:

Provides detailed insights into product sales and usage trends, highlighting top-selling products and those in high demand. This helps pharmacies make informed decisions about inventory replenishment and stock management.
### Patient-Centric Features:

-Medication Schedule Interface: Patients can view their medication schedules with date and time details using a calendar interface.

-Pharmacy Locator: Helps patients find nearby pharmacies based on their location and needs.

-LotusAI Chatbot: An AI-driven chatbot that assists patients with medication information, side effects, usage instructions, pharmacy inquiries, and general healthcare questions.

 ## 2.Realization

### Technologies and Frameworks

#### Backend
##### -Framework: Node.JS
<a href="https://nodejs.org/en" target="_blank" rel="noreferrer"
    ><img
      src="https://upload.wikimedia.org/wikipedia/commons/d/d9/Node.js_logo.svg"
      width="60"
      height="60"
      alt="NodeJS" /></a>

##### -Database: PostgreSQL


#### Dashboard (Website for Pharmacies)
##### -Framework: Next.js
<a href="https://ibb.co/D4YpJvX"><img src="https://i.ibb.co/G79T68w/next.png" alt="next" border="0" height=36 width=36 /></a>

##### -Styling: Tailwind CSS and ShadcnUi


#### Mobile App (for Patients)
##### -Framework: Flutter
<a href="https://flutter.dev/" target="_blank" rel="noreferrer"
    ><img
      src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/skills/flutter-colored.svg"
      width="36"
      height="36"
      alt="Flutter" /></a>
##### -State Management: SetState

##### -API Integration: http


### Code Showcase (Some pieces from our hard coding)
#### Backend - Express.js with PostgreSQL
```bash
const express = require('express');
const { Pool } = require('pg');

const app = express();
app.use(express.json());

// PostgreSQL configuration
const pool = new Pool({
    host: '127.0.0.1',
    port: 5432,
    database: 'postgres',
    user: 'postgres',
    password: '0798464688',
    max: 10,
    idleTimeoutMillis: 1000,
    connectionTimeoutMillis: 10000
});

```

#### Endpoints
##### 1. Login Endpoint

```javascript
// Endpoint: login
app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT id FROM Patient WHERE username = $1 AND password = $2';
    try {
        const result = await pool.query(query, [username, password]);
        if (result.rows.length === 0) {
            return res.status(404).send('Not Found');
        }
        return res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error(err);
        return res.status(500).send('Internal Server Error');
    }
});

```

##### 2. Number of Suppliers Endpoint
```javascript
// Endpoint: numsup
app.get('/numsup', async (req, res) => {
    const query = 'SELECT count(*) as total FROM suppliers';
    try {
        const result = await pool.query(query);
        return res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error(err);
        return res.status(500).send('Internal Server Error');
    }
});


```

##### 3. Total Medications Sold Endpoint
```javascript
// Endpoint: medsold
app.get('/medsold', async (req, res) => {
    const query = 'SELECT sum(qte_sold) as total FROM sales';
    try {
        const result = await pool.query(query);
        return res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error(err);
        return res.status(500).send('Internal Server Error');
    }
});

```

##### 4. Total Medications Sold Endpoint
```javascript
// Endpoint: listmeds
app.get('/listmeds', async (req, res) => {
    const query = `SELECT d.id, d.name, d.category, d.description, d.unit_price, d.unit_reduction_price, 
                   d.reorder_level, d.expiration_date, d.stock_level, i.qte, i.room, i.last_updated 
                   FROM inventory i 
                   JOIN drugs d ON i.medication_id::integer = d.id`;
    try {
        const result = await pool.query(query);
        return res.status(200).json(result.rows);
    } catch (err) {
        console.error(err);
        return res.status(500).send('Internal Server Error');
    }
});


```

##### 5. List Suppliers Endpoint
```javascript
// Endpoint: listsups
app.get('/listsups', async (req, res) => {
    const query = 'SELECT * FROM suppliers';
    try {
        const result = await pool.query(query);
        return res.status(200).json(result.rows);
    } catch (err) {
        console.error(err);
        return res.status(500).send('Internal Server Error');
    }
});



```

#### Server Initialization

```javascript
const port = 3000;
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});



```

#### Dashboard (Pharmacy)

##### 1. useEffect (it fetches the request everytime the page gets reload)

```typescript
  const keySuppliers = "numsup";
  const keyMedsold = "medsold";

  const [totalSuppliers, setTotalSuppliers] = useState<string>("");
  const [totalMedsold, setTotalMedsold] = useState<string>("");

  useEffect(() => {
    const fetchSuppliers = async () => {
      try {
        const response = await fetch(`${apiEndPoint}${keySuppliers}`);
        const data = await response.json();
        const total = data[0].total.toString();
        setTotalSuppliers(total);
      } catch (error) {
        alert(`Error fetching suppliers data: ${error}`);
      }
    };

    const fetchMedsold = async () => {
      try {
        const response = await fetch(`${apiEndPoint}${keyMedsold}`);
        const data = await response.json();
        const total = data[0].total.toString();
        setTotalMedsold(total);
      } catch (error) {
        alert(`Error fetching medecines data: ${error}`);
      }
    };

    fetchSuppliers();
    fetchMedsold();
  }, []);



```

##### 2. GET Suppliers of medications informations

```typescript
import { Payment, columns } from "@/app/components/suppliers/columns";
import { DataTable } from "@/app/components/suppliers/data-table";
import { apiEndPoint } from "@/app/config/config";

async function getData(): Promise<Payment[]> {
  const key = "listsups";
  const response = await fetch(`${apiEndPoint}${key}`);
  if (!response.ok) {
    throw new Error("Failed to fetch data");
  }
  const data: Payment[] = await response.json();
  return data;
}

export default async function Page() {
  const data = await getData();

  return (
    <div className="container mx-auto py-10">
      <DataTable columns={columns} data={data} />
    </div>
  );
}



```

##### 3. GET Medications informations :

```typescript
import { Payment, columns } from "@/app/components/medecines/columns";
import { DataTable } from "@/app/components/medecines/data-table";
import { apiEndPoint } from "@/app/config/config";

async function getData(): Promise<Payment[]> {
  const key = "listmeds";
  const response = await fetch(`${apiEndPoint}${key}`);
  if (!response.ok) {
    throw new Error("Failed to fetch data");
  }
  const data: Payment[] = await response.json();
  return data;
}

export default async function Page() {
  const data = await getData();

  return (
    <div className="container mx-auto py-10">
      <DataTable columns={columns} data={data} />
    </div>
  );
}



```


#### Mobile Application (Patient)

##### 1. LotusAI ChatBot (Using Goole Gemini APIs with some limitations)

```dart
import 'package:flutter/material.dart';
import 'package:generative_model/generative_model.dart';

class AIChatBot extends StatefulWidget {
  @override
  _AIChatBotState createState() => _AIChatBotState();
}

class _AIChatBotState extends State<AIChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  DateTime? _lastRequestTime;
  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: 'YOUR_API_KEY');
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"sender": "user", "message": message});
    });
    try {
      if (_lastRequestTime != null) {
        final timeSinceLastRequest = DateTime.now().difference(_lastRequestTime!);
        if (timeSinceLastRequest.inSeconds < 20) {
          await Future.delayed(Duration(seconds: 20 - timeSinceLastRequest.inSeconds));
        }
      }
      _lastRequestTime = DateTime.now();
      final content = [Content.text("Please limit your responses to pharmacies and their medicines in Algeria. $message")];
      final response = await _model.generateContent(content);
      final botMessage = response.text?.trim() ?? "Sorry, I couldn't process your request.";
      setState(() {
        _messages.add({"sender": "bot", "message": botMessage});
      });
    } catch (error) {
      setState(() {
        _messages.add({"sender": "bot", "message": "Sorry, an error occurred: $error"});
      });
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/chatboticon.png'),
              radius: 25,
            ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message['message']!,
              style: TextStyle(color: isUser ? Colors.white : Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 125),
                  Text('LotusAI', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/chat_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessage(_messages[index]);
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Type a question..', border: InputBorder.none),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      final message = _controller.text;
                      if (message.isNotEmpty) {
                        _sendMessage(message);
                        _controller.clear();
                      }
                    },
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}





```
![alt text](https://github.com/faridlaoudi/Lotus-NCShack/blob/main/Screenshots/LotusAI.png)

##### 2. Medication Schedules

```dart
import 'package:flutter/material.dart';
import 'package:lotus/colors.dart' as colors;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Meds extends StatefulWidget {
  const Meds({super.key});

  @override
  State<Meds> createState() => _MedsState();
}

class _MedsState extends State<Meds> {
  final TextEditingController _searchController = TextEditingController();
  List medications = [];

  @override
  void initState() {
    super.initState();
    fetchMedications();
  }

  Future<void> fetchMedications() async {
    final response = await http.get(Uri.parse('https://api.example.com/medications'));
    if (response.statusCode == 200) {
      setState(() {
        medications = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load medications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  _buildInputField(_searchController, 'Search', Icons.search),
                  SizedBox(height: 25),
                  ...medications.map((med) => MedicationWidget(med: med)).toList(),
                ],
              ),
            ),
            Spacer(),
            // Your bottom navigation bar here
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Icon(icon, color: colors.TextColor2.withOpacity(0.3)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}

class MedicationWidget extends StatelessWidget {
  final Map med;

  MedicationWidget({required this.med});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Text('Available At:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Pharmacie De garde Khaldoun'),
                // Add more details here
                SizedBox(height: 20),
                Text('Side Effects:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Dizziness, lightheadedness, etc.'),
                SizedBox(height: 20),
                Text('How to use:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Take this medication by mouth as directed by your doctor.'),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isOutOfStock = med['stockLevel'] == 0;
    return Container(
      width: 333,
      height: 84,
      padding: EdgeInsets.symmetric(horizontal: 17),
      margin: EdgeInsets.only(bottom: 15.86),
      decoration: BoxDecoration(
        color: isOutOfStock ? Color(0xFFFFEBEB) : Color(0xFFE5F8FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.medication, color: isOutOfStock ? Colors.red : Colors.blue, size: 30),
          SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(med['name'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Icon(isOutOfStock ? Icons.report_problem : Icons.check_circle, color: isOutOfStock ? Colors.red : Colors.blue, size: 16),
                  SizedBox(width: 5),
                  Text(isOutOfStock ? 'Out of Stock' : 'Available'),
                ],
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_right, color: Colors.black),
            onPressed: () => _showBottomSheet(context),
          ),
        ],
      ),
    );
  }
}





```
