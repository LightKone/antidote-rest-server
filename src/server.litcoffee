## Load required packages

Using [express](https://expressjs.com) to provide a simple way to create a web
server

    express = require 'express'

We are accessing AntidoteDB using the
[Antidote TypeScript Client](https://github.com/SyncFree/antidote_ts_client):

    antidoteClient = require 'antidote_ts_client'

Get package information

    packageInfo = require '../package.json'

## The Antidote REST Server class

    class AntidoteRestServer

      running: false

      constructor: (@antidoteHost, @antidotePort, @webServerPort) ->
        @antidote = antidoteClient.connect(@antidotePort, @antidoteHost)
        @webServer = express()

      start: () ->
        if not @running
          @running = true
          httpServer = @webServer.listen(@webServerPort)
          @getHttpServer = () -> httpServer
          @webServer.use (req, res, next) ->
            # log all requests to console
            #console.log "> #{req.method.toUpperCase()} #{req.url}"
            # tihs REST API replies in text/plain
            # TODO: change API to return JSON data
            res.type 'text/plain'
            next()
          @webServer.use '/counter',    require('./v1/counter')(@antidote)
          @webServer.use '/integer',    require('./v1/integer')(@antidote)
          @webServer.use '/register',   require('./v1/register')(@antidote)
          @webServer.use '/mvregister', require('./v1/mvregister')(@antidote)
          @webServer.use '/set',        require('./v1/set')(@antidote)

      stop: () ->
        if @running
          @getHttpServer().close()
          @running = false

      printConfiguration: () ->
        # TODO add a logger, such as
        # [Winston](http://www.npmjs.com/package/winston)
        console.log "Antidote REST Server v#{packageInfo.version}"
        console.log "Using Antidote at #{@antidoteHost}:#{@antidotePort}"
        console.log "REST Server listening on port #{@webServerPort}"

    module.exports = AntidoteRestServer
