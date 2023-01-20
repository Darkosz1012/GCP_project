const functions = require('@google-cloud/functions-framework');
const Firestore = require('@google-cloud/firestore');

const projectId = process.env.GCP_PROJECT || process.env.GCLOUD_PROJECT
const COLLECTION_NAME = 'cloud-functions-firestore';

const firestore = new Firestore({
  // projectId: projectId,
  timestampsInSnapshots: true
});

functions.http('create', async (req, res) => {
  if (req.method === 'POST') {
    const data = (req.body) || {};
    const name = (data.name || '')
      .replace(/[^a-zA-Z0-9\-_!.,; ']*/g, '')
      .trim();
    const created = new Date().getTime();

    return firestore.collection(COLLECTION_NAME).add({
      created,
      name
    }).then(doc => {
      console.info('stored new doc id#', doc.id);
      return res.status(200).send(doc);
    }).catch(err => {
      console.error(err);
      return res.status(404).send({
        error: 'unable to store',
        err
      });
    });
  }else{
    const collection = firestore.collection(COLLECTION_NAME);
    const snapshot = await collection.get();
  
    res.status(200).send(snapshot.docs.map((doc) => {
        return { id: doc.id, ...doc.data() }
      }));
  }
});