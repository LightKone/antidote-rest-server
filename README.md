# antidote-rest-client
An HTTP/HTTPS REST API for AntidoteDB

## Installation
`$ npm install`

## Configuring
In `index.js`:

- `ANTIDOTE_REST_API_HOST_NAME`: hostname of the Antidote instance (default: `localhost`)
- `ANTIDOTE_REST_API_HOST_PORT`: port of the Antidote instance (default: `8087`)
- `ANTIDOTE_REST_API_PORT`: web server port (default: `3000`)

## Running
`$ npm run-script start-server`

Then fire up your browser to [localhost:3000](http://localhost:3000)

## API
Only implementing a subset of the available CRDTs in Antidote:

- `/counter/read/:bucket/:key`
- `/counter/increment/:bucket/:key/:amount?`
- `/integer/read/:bucket/:key`
- `/integer/increment/:bucket/:key/:amount?`
- `/integer/set/:bucket/:key/:value`
- `/set/read/:bucket/:key`
- `/set/add/:bucket/:key/:elem`
- `/set/remove/:bucket/:key/:elem`