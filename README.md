# customer_risk_analysis_api
Connecting to DB and writing a simple API to display risky profiles of customers according to the data given as input

![customer_risk_analysis_concept drawio](https://user-images.githubusercontent.com/26508636/175780245-76b9e93a-3653-455f-93c9-09eca667f54e.png)

## What does this do?
* Is this just yet another run of the mill code done for getting a job? Nope
* It has simple support for CRUD operations using mysql and express js, which is understandable, extendable and can be implemented in any other language after understanding the flow
* The focus here was on the process and not the end result, which is an important value for any developer
* It makes use of GH workflows like Node.js linter, super linter which help in CI for running static checks against modifications made in existing / modified code across different langauges like bash, js, mysql, etc.

## Sample API

```js
app.get('/risky_identities/:customer_id', async (req, res) => {
  const query = 'SELECT email, phone, creditcard FROM test_view WHERE customer_id = ?'
  pool.query(query, [req.params.customer_id], (error, results) => {
    if (error) {
      res.json({ status: '502 internal server error' })
    }
    if (!results[0]) {
      res.json({ status: '404 not found' })
    } else {
      res.json(results[0])
    }
  })
})
```

### Handling condition where entries of phone and creditcard are not available

```js
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
        if(!results[0]) {
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
```

### Output
1. **For entity found**

![insomnia_rest_client](https://user-images.githubusercontent.com/26508636/175968658-bd3b43fe-fa1a-4a3b-ac51-77b89b372055.png)

![result_risky_customer](https://user-images.githubusercontent.com/26508636/175752950-5c2d23fb-a2b2-4940-ba30-03c71908967d.png)

2. **Unknown entity**

![not_found_risky](https://user-images.githubusercontent.com/26508636/175753096-65cdc3d2-b2cd-493b-992a-26208e6f0672.png)

3. **In case only email is found for a customer_id**

![only_email_risky](https://user-images.githubusercontent.com/26508636/175753372-555c3c74-80dc-4943-941b-4b79a8b666bc.png)
