const express = require('express')
const {Firestore} = require('@google-cloud/firestore');
const bodyParser = require("body-parser")
const app = express()
const port = process.env.PORT || 3000

const firestore = new Firestore();

const productsCollection = firestore.collection('products')

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

app.use(require('sanitize').middleware);

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/search', async (req, res) => {
    var result = await productsCollection.limit(10).get();
    res.send(result)
})

app.post("/product/add", async (req, res) => {
    
    console.log("create",req.body)
    var result =  await productsCollection.add(req.body)
    res.status(200)
    res.send(result)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})