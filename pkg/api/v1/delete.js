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
const port = 3030
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
  console.log(`app listening at http://localhost:${port}`)
})

app.get('/delete/risky_email/:customer_id', (req, res) => {
  const deleteEmailQuery = 'DELETE FROM risky_email WHERE customer_id=?'
  pool.query(deleteEmailQuery, [req.params.customer_id], (error, results) => {
    if (error) {
      res.json(error)
    } else {
      res.sendStatus(200)
      res.json(results[0])
    }
  })
})

app.get('/delete/risky_phone/:customer_id', (req, res) => {
  const deleteEmailQuery = 'DELETE FROM risky_phone WHERE customer_id=?'
  pool.query(deleteEmailQuery, [req.params.customer_id], (error, results) => {
    if (error) {
      res.json(error)
    } else {
      res.sendStatus(200)
      res.json(results[0])
    }
  })
})

app.get('/delete/risky_creditcard/:customer_id', (req, res) => {
  const deleteEmailQuery = 'DELETE FROM risky_creditcard WHERE customer_id=?'
  pool.query(deleteEmailQuery, [req.params.customer_id], (error, results) => {
    if (error) {
      res.json(error)
    } else {
      res.sendStatus(200)
      res.json(results[0])
    }
  })
})
