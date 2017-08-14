# antidote-rest-client
An HTTP/HTTPS REST API for [AntidoteDB](http://syncfree.github.io/antidote), written in **Literate IcedCoffeeScript**.

## Installing using NPM
Coming soon. Still not published.

## Installing from Source
- `$ git clone https://github.com/joaomlneto/antidote-rest-client.git`
- `$ cd antidote-rest-client`
- `$ npm install`

## Configuring
##### In `config.js`:
- `ANTIDOTE_REST_API_HOST_NAME`:
hostname of the Antidote instance (default: `localhost`)
- `ANTIDOTE_REST_API_HOST_PORT`:
port of the Antidote instance (default: `8087`)
- `ANTIDOTE_REST_API_PORT`:
web server port (default: `3000`)

## Testing
###### Optionally, if you want to check everything is OK:
- `$ npm test`

## Running
- `$ npm start`

Then fire up your browser to [localhost:3000](http://localhost:3000)

## REST API
Only implementing a subset of the available CRDTs in Antidote:

- GET `/counter/read/:bucket/:key`
- GET `/counter/increment/:bucket/:key/:amount?`
- GET `/integer/read/:bucket/:key`
- GET `/integer/increment/:bucket/:key/:amount?`
- GET `/integer/set/:bucket/:key/:value`
- GET `/set/read/:bucket/:key`
- GET `/set/add/:bucket/:key/:elem`
- GET `/set/remove/:bucket/:key/:elem`
