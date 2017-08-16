## Load required packages

    conf = require 'nconf'
    express = require 'express'
    antidoteClient = require 'antidote_ts_client'

## Load configuration

    conf.argv().env()

    antidoteHost = conf.get 'antidote:hostname'
    antidoteHost ?= 'localhost'

    antidotePort = conf.get 'antidote:port'
    antidotePort ?= '8087'

    serverPort = conf.get('server:port')
    serverPort ?= 3000

## Connect to Antidote

    antidote = antidoteClient.connect(antidotePort, antidoteHost)
    console.log "Using Antidote at #{antidoteHost}:#{antidotePort}"

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

    console.log "Listening on port #{serverPort}"

## API

    server.use '/counter', require('./routes/counter')(server, antidote)

    server.use '/integer', require('./routes/integer')(server, antidote)

    server.use '/register', require('./routes/register')(server, antidote)

    server.use '/mvregister', require('./routes/mvregister')(server, antidote)

    server.use '/set', require('./routes/set')(server, antidote)

## For testing

    module.exports = server
