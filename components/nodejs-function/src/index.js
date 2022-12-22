const functions = require('@google-cloud/functions-framework');


functions.http('create', (req, res) => {
  res.send(`Test create`);
});