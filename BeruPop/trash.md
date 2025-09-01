SELECT * FROM <table> WHERE Entity_Type = "User" => Get All
SELECT * FROM <table> WHERE PK = ":id" => Get By, One-To-Many
SELECT * FROM <table> WHERE SK = ":id" => Many-To-Many

// We Should Resolve Everything in One Query
// From What I can Tell, We're trying to make multiple GET Request for 1 Page
// One News can Have Many Users

// One News Can Have Many IP Series
// One IP Series can Have Many News

// Social Media Platform

// Filter By Platform, Begins With

// Entities

// Access Patterns

getAllUsers
getAllIpSeries
getAllIncidents
getUserAttributesByUser
// Add Index where PK is Value, and SK is Entity Type

getUserByUserAttributes
getIncidentByIpSeries
getIpSeriesByIncident
getUsersByIncident

I am currently Researching DynamoDb and I have two entities, User and Job 

Let's Assume a User can have multiple Jobs, and a Jobs can Have Multiple Users

I would like to list out all user whom have the following job Role, Software Engineer and Teacher. This query should return all User Id
I want to get the Details of The User. How would I do this? Is my approach correct?

Use Query, then BatchGet
