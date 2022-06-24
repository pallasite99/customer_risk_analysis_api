const mysql = require('mysql2')

const config = mysql.createConnection({

  // done for testing, do not expose sensitive data like this anywhere
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'customer_schema'
})

config.connect(function (err) {
  if (err) {
    return console.error('error: ' + err.message)
  }

  console.log('Connected to the MySQL server.')
})

module.exports = config;