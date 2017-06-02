# Metrics

An analytic service that allows users to track events on websites. It is written in Ruby on Rails.
Users can integrate with any web applications to track user activities and report results.

# Features

+ A client-side JavaScript snippet that allows a user to track events on their website.
+ A server-side API that captures and saves those events to a database.

The app is deployed on Heroku: https://metrics-tm.herokuapp.com/

The source code is here on GitHub: https://github.com/tmoolmuang/metrics

This app was created as part of the [Bloc](www.bloc.io) Web Developer Track.

![m1](https://cloud.githubusercontent.com/assets/24881495/26710197/0cb94b34-470d-11e7-80ec-40f297a1abda.JPG)


# Setup and Configuration

**Languages and Frameworks**: Ruby on Rails and Bootstrap

**Ruby version 2.3.0**

**Rails version 4.2.5**

**Databases**: SQLite (Test, Development), PostgreSQL (Production)

**Development Tools and Gems include**:

+ Devise for user authentication
+ Chartkick for JavaScript chart

# Create a JavaScript Snippet

Metrics users must be able to track events using JavaScript snippets. 
There's only one function your snippet needs to support.
Inside this function, use a POST request to create the event. Assume that jQuery is not present, 
and use the Ajax functions that are native to web browsers instead (the XMLHttpRequest API).

```
var blocmetrics = {};
blocmetrics.report = function(eventName){
  var event = {event: { name: eventName }};
  var request = new XMLHttpRequest();
  request.open("POST", "[..your metrics website..]/api/events", true); /* https://metrics-tm.herokuapp.com */
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(event));
};
```
Add your JavaScript code to the application you want to track. 
Trigger the tracked event in your browser by calling:
```
blocmetrics.report("[..event name..]") 
```
![metrics2](https://cloud.githubusercontent.com/assets/24881495/26710235/42f4135a-470d-11e7-905b-a4c9d7514b31.JPG)
