## Load required packages

Using [nconf](https://www.npmjs.com/package/nconf) to parse the command line
arguments and environment variables

    conf = require 'nconf'

Using [express](https://expressjs.com) to provide a simple way to create a web
server

    express = require 'express'

We are accessing AntidoteDB using the
[Antidote TypeScript Client](https://github.com/SyncFree/antidote_ts_client)

    antidoteClient = require 'antidote_ts_client'

## Load and display configuration

Get package information

    packageInfo = require '../package.json'

Load configuration from command line and/or environment

    ## TODO: also add the possibility of having a config file
    conf.argv().env()

The hostname and port of the AntidoteDB instance

    antidoteHost = conf.get 'antidote:hostname'
    antidoteHost ?= 'localhost'

    antidotePort = conf.get 'antidote:port'
    antidotePort ?= '8087'

The REST Server listening port

    serverPort = conf.get('server:port')
    serverPort ?= 3000

Print configuration information

    # TODO add a logger, such as [Winston](http://www.npmjs.com/package/winston)
    console.log "Antidote REST Server v#{packageInfo.version}"
    console.log "Using Antidote at #{antidoteHost}:#{antidotePort}"
    console.log "REST Server listening on port #{serverPort}"

## Connect to Antidote

    antidote = antidoteClient.connect(antidotePort, antidoteHost)

## Setup Web Server

    server = express()
    server.listen(serverPort)

    server.use (req, res, next) ->
      # log all requests to console
      #console.log "> #{req.method.toUpperCase()} #{req.url}"
      # this REST API replies in text/plain
      # TODO: change API to return JSON data
      res.type 'text/plain'
      next()

## Setup REST API Routes

    server.use '/counter', require('./routes/counter')(server, antidote)

    server.use '/integer', require('./routes/integer')(server, antidote)

    server.use '/register', require('./routes/register')(server, antidote)

    server.use '/mvregister', require('./routes/mvregister')(server, antidote)

    server.use '/set', require('./routes/set')(server, antidote)

#### Required for testing

    module.exports = server
