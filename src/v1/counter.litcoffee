    module.exports = (antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        counter = antidote.counter req.params.key
        value = await counter.read()
        res.send String value
        next()

      router.route '/increment/:bucket/:key/:amount?'
        .get (req, res, next) ->
          amount = parseInt(req.params.amount ?= 1) # default amount = 1
          antidote.defaultBucket = req.params.bucket
          counter = antidote.counter req.params.key
          response = await antidote.update counter.increment amount
          res.send('ok')
          next()
        .put (req, res, next) ->
          amount = parseInt(req.params.amount ?= 1) # default amount = 1
          antidote.defaultBucket = req.params.bucket
          counter = antidote.counter req.params.key
          response = await antidote.update counter.increment amount
          res.send('ok')
          next()

      return router
