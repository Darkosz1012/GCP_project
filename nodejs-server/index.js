const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/search', (req, res) => {
    res.send({
        data:[
            {
                id:"1",
                name:"test1"
            },
            {
                id:"2",
                name:"test2"
            }
        ]
    })
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})