require('dotenv').config();
const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');
const cors = require('cors');
const jwt = require('jsonwebtoken');

const app = express();
app.use(cors({ origin: '*' })); // Allow all origins (adjust if needed)
app.use(express.json());

// ✅ Secure Database Connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // Use environment variable
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false, // Enable SSL for production
});

pool.connect()
  .then(() => console.log("✅ Connected to PostgreSQL"))
  .catch(err => console.error("❌ Database connection error:", err));

// ✅ Middleware to log incoming requests
app.use((req, res, next) => {
  console.log(`📢 ${req.method} ${req.url}`);
  console.log("📢 Body:", req.body);
  next();
});

// ✅ **Signup Route**
app.post('/signup', async (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).json({ error: 'All fields are required' });
  }

  try {
    // Check if the email is already taken
    const existingUser = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (existingUser.rows.length > 0) {
      return res.status(400).json({ error: 'Email already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const result = await pool.query(
      'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id, name, email',
      [name, email, hashedPassword]
    );

    res.status(201).json({ message: '✅ User registered successfully', user: result.rows[0] });
  } catch (err) {
    console.error("❌ Signup Error:", err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// ✅ **Login Route**
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  try {
    const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }

    const user = result.rows[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }

    // ✅ Use JWT secret strictly from `.env`
    if (!process.env.JWT_SECRET) {
      return res.status(500).json({ error: 'JWT secret not configured' });
    }

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ message: '✅ Login successful', token, user: { id: user.id, name: user.name, email: user.email } });
  } catch (err) {
    console.error("❌ Login Error:", err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// ✅ **Start Server with Port Handling**
const PORT = process.env.PORT || 5000;
const server = app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});

// ✅ Handle Port In Use Error (EADDRINUSE)
server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`❌ Port ${PORT} is already in use. Trying port ${PORT + 1}...`);
    app.listen(PORT + 1, () => console.log(`🚀 Server running on port ${PORT + 1}`));
  } else {
    console.error("❌ Server Error:", err);
  }
});
