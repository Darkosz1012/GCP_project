# GCP_project
## Goal
The application will have the task of saving items to the database.

## Infrastructure
The infrastructure will be built using terraform on the Google Cloud Platform. Below is a diagram showing its architecture.
![image](https://user-images.githubusercontent.com/26382728/213666532-9253e93b-cb5e-4f3a-bd32-3e1c5539f687.png)

### API Gateway
Api gateway exposes one endpoint for the entire application and all its services.

### Cloud Functions
Allows you to add items to the database and get all items from database It is written in Node.js.

### Cloud Firestore
Firestore is a document database that I decided to use to store items information.

### Cloud Storage
In it, I store all the application code that is called by other services.

### Cloud Monitoring
In addition, in order to control the operation of the application, I configure the Cloud Monitoring service.
