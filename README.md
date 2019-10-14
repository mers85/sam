# README

SAM is a system for entering and leaving employees.

## Requirements:

* Ruby 2.6.1
* Rails 6
* bundler - gem install bundler
* Yarn - brew install yarn or Install Yarn
* Redis - For ActionCable support
* Foreman - gem install foreman - helps run all your processes in development

## Database creation
* Run the app and sign up, by default the user is an employee
* For now: To create an Admin you can run on rails console 
  user = User.create(email: "email", password: "password", admin: true), user.save

### How to run the test suite
* use foreman start

### Api Docs
* run the app
* Go to this link  http://localhost:5000/api_docs/v1

* ...
