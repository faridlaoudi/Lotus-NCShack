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


### Code Showcase
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

```bash
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
```bash
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
```bash
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
```bash
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
```bash
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

```bash
const port = 3000;
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});



```
