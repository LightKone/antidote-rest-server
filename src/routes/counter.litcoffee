    module.exports = (webserver, antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        counter = antidote.counter req.params.key
        await counter.read().then defer value
        res.send String value
        next()

      router.get '/increment/:bucket/:key/:amount?', (req, res, next) ->
        amount = parseInt(req.params.amount ?= 1) # default amount = 1
        antidote.defaultBucket = req.params.bucket
        counter = antidote.counter req.params.key
        await antidote.update(counter.increment(amount)).then defer response
        res.send('ok')
        next()

      return router
