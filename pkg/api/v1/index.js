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
const port = 3000
app.use(express.json())
app.use(
  express.urlencoded({
    extended: true
  })
)
// this is invoked when http://localhost:3000 is entered in browser
app.get('/', (req, res) => {
  res.json({ message: 'ok' })
})
// keep our app in listening mode for all incoming requests
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

// main api used for querying risky_customer_profiles
// uses a simple REQ-RES model without any caching of requests
app.get('/risky_identities/:customer_id', async (req, res) => {
  // test_view here is a table, which is primarily a view created from three
  // different tables called risky_email, risky_phone, risky_creditcard
  const query = 'SELECT email, phone, creditcard FROM test_view WHERE customer_id = ?'
  pool.query(query, [req.params.customer_id], (error, results) => {
    // this would mean a malformed request or error
    // in establishing connection to backend server
    if (error) {
      res.json({ status: '502 internal server error' })
    }
    // this means that while record related to phone number and creditcard were
    // not found, the API will instead search for the email of customer and return
    // the data
    if (!results[0]) {
      const emailQuery = 'SELECT email FROM risky_email WHERE customer_id = ?'
      pool.query(emailQuery, [req.params.customer_id], (error, results) => {
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
      // this contains the relevant data in JSON format about
      // email,phone number and creditcard info for a specified customer_id
      res.json(results[0])
    }
  })
})
