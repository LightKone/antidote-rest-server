[![Build Status](https://travis-ci.org/joaomlneto/antidote-rest-server.svg?branch=master)](https://travis-ci.org/joaomlneto/antidote-rest-server)
[![Dependencies](https://img.shields.io/david/joaomlneto/antidote-rest-server.svg?style=flat-square)](https://david-dm.org/joaomlneto/antidote-rest-server)

# Antidote REST Server
An HTTP/HTTPS REST API for [AntidoteDB](http://syncfree.github.io/antidote), written in **Literate IcedCoffeeScript**.

## Dependencies
Requires `iced-coffee-script` installed globally:
- `$ npm install -g iced-coffee-script`

## Installing using NPM
- `$ npm install -g antidote-rest-server`
- `$ antidote-rest-server`

## Installing from Source
- `$ git clone https://github.com/joaomlneto/antidote-rest-server.git`
- `$ cd antidote-rest-server`
- `$ npm test` (optionally, if you want to check everything is OK)
- `$ npm install`
- `$ npm start`

Then fire up your browser to [localhost:3000](http://localhost:3000)

## Configuring
Configuration is done through the command line.
See below the options and default values.
- Antidote hostname: `--antidote:hostname=localhost`
- Antidote port: `--antidote:port=8087`
- REST server port: `--server:port=3000`

## REST API
Only implementing a subset of the available CRDTs in Antidote:

#### PN Counter
- GET `/counter/read/:bucket/:key`
- GET/PUT `/counter/increment/:bucket/:key/:amount?`

#### Integer
- GET `/integer/read/:bucket/:key`
- GET/PUT `/integer/increment/:bucket/:key/:amount?`
- GET/PUT `/integer/set/:bucket/:key/:value`

#### Set
- GET `/set/read/:bucket/:key`
- GET/PUT/POST `/set/add/:bucket/:key/:elem`
- GET/DELETE `/set/remove/:bucket/:key/:elem`

#### LWW Register
- GET `/register/read/:bucket/:key`
- GET/PUT `/register/set/:bucket/:key/:value`

#### MV Register
- GET `/mvregister/read/:bucket/:key`
- GET/PUT `/mvregister/set/:bucket/:key/:value`
