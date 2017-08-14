    module.exports = (webserver, antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        integer = antidote.integer req.params.key
        await integer.read().then defer value
        res.send String value
        next()

      router.get '/increment/:bucket/:key/:amount?', (req, res, next) ->
        amount = parseInt(req.params.amount ?= 1) # default amount = 1
        antidote.defaultBucket = req.params.bucket
        integer = antidote.integer req.params.key
        await antidote.update(integer.increment(amount)).then defer response
        res.send "ok"
        next()

      router.get '/set/:bucket/:key/:value', (req, res, next) ->
        value = parseInt(req.params.value)
        antidote.defaultBucket = req.params.bucket
        integer = antidote.integer req.params.key
        await antidote.update(integer.set(value)).then defer response
        res.send "ok"
        next()

      return router
