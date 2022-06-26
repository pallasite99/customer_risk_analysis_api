// this acts as the HTTP server or a bridge between frontend and backend
const express = require('express')
// for connecting and querying the database store
const mysql = require('mysql2')
// keep a connection pool active to avoid creating separate connection
// for each query to backend
const pool = mysql.createPool({
  user: 'root',
  password: 'root',
  database: 'customer_schema',
  host: 'localhost'
})

// this will be our express app that will handle the REQ and send back
// requested RES back to the user
const app = express()
// arbitrary port specified, anything apart from 3306 used by mysql would work on localhost
// unless there is any other service running on the arbitrary port prior to running this sample
const port = 3020
app.use(express.json())
app.use(
  express.urlencoded({
    extended: true
  })
)
// this is invoked when http://localhost:3000 is entered in browser
app.post('/', (req, res) => {
  res.json({ message: 'ok' })
})

// keep our app in listening mode for all incoming requests
app.listen(port, () => {
  console.log(`insert app listening at http://localhost:${port}`)
})

// insert given custpmer_id and email into risky_email table
// returns status 200 if OK else error status code
app.get('/insert/risky_email/:customer_id/email/:email', (req, res) => {
  const insertEmailQuery = 'INSERT INTO risky_email VALUES (?, ?)'
  pool.query(insertEmailQuery, [req.params.customer_id, req.params.email], (error, results) => {
    if (error) {
      res.json(error)
    } else {
      res.sendStatus(200)
      res.json(results[0])
    }
  })
})
