# GCP_project
## Goal
The application will have the task of displaying a product search engine and, if possible, allowing you to manage products.

## Infrastructure
The infrastructure will be built using terraform on the Google Cloud Platform. Below is a diagram showing its architecture.
![Untitled-2022-12-16-1021](https://user-images.githubusercontent.com/26382728/208067948-89950b8e-5cca-4bd6-9042-cc7a25e054f1.png)

### API Gateway
Api gateway exposes one endpoint for the entire application and all its services.

### Cloud Functions
Allows you to add products to the database. It is written in Node.js.

### App Engine
It exposes product search api and hosts SPA written in Angular. It is written in Node.js.

### Cloud Firestore
Firestore is a document database that I decided to use to store product information.

### Cloud Storage
In it, I store all the application code that is called by other services.

### Cloud Monitoring
In addition, in order to control the operation of the application, I configure the Cloud Monitoring service.
