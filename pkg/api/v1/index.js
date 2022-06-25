const express = require('express')
const mysql = require('mysql2')
const pool = mysql.createPool({
  user: 'root',
  password: 'root',
  database: 'customer_schema',
  host: 'localhost'
})
const app = express()
const port = 3000
app.use(express.json())
app.use(
  express.urlencoded({
    extended: true
  })
)
app.get('/', (req, res) => {
  res.json({ message: 'ok' })
})
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

app.get('/risky_identities/:customer_id', async (req, res) => {
  const query = 'SELECT email, phone, creditcard FROM test_view WHERE customer_id = ?'
  pool.query(query, [req.params.customer_id], (error, results) => {
    if (error) {
      res.json({ status: '502 internal server error' })
    }
    if (!results[0]) {
      const email_query = 'SELECT email FROM risky_email WHERE customer_id = ?'
      pool.query(email_query, [req.params.customer_id], (error, results) => {
        if (error) {
          res.json({ status: '502 internal server error' })
        }
        if (!results[0]) {
          res.json({ status: '404 not found' })
        } else {
          res.json(results[0])
        }
      })
    } else {
      res.json(results[0])
    }
  })
})
