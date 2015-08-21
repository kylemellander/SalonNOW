# SalonNow

##### A template for managing a salon's stylists and clients, August 21, 2015

#### By Kyle Mellander

## Description

This web app is a starter design for the creation of a hair salon page.  It can manage both stylists and clients while creating associations beyond the two. It also allows you to schedule an appointment and view all the appointments coming up.  Further updates should bring a list page for all appointments for stylists and clients.

## Setup

* Clone from Github (https://github.com/kylemellander/salonNOW.git)
* $ bundle install
* $ psql
    * CREATE DATABASE hair_salon;
    * \c hair_salon;
    * CREATE TABLE stylists (id serial PRIMARY KEY, first_name varchar, last_name varchar);
    * CREATE TABLE clients (id serial PRIMARY KEY, first_name varchar, last_name varchar, phone varchar, stylist_id int);
    * CREATE TABLE appointments (id serial PRIMARY KEY, stylist_id int, client_id int, time timestamp);
* $ ruby app.rb in the root folder
* Have fun!

---------------------------


## Technologies Used

Ruby, CSS, HTML, Sinatra, Capybara, and rspec, Postgres

### Legal

Copyright (c) 2015 Kyle Mellander

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
