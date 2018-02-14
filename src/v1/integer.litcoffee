    module.exports = (antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        integer = antidote.integer req.params.key
        value = await integer.read()
        res.send String value
        next()

      router.route '/increment/:bucket/:key/:amount?'
        .get (req, res, next) ->
          amount = parseInt(req.params.amount ?= 1) # default amount = 1
          antidote.defaultBucket = req.params.bucket
          integer = antidote.integer req.params.key
          response = await antidote.update integer.increment amount
          res.send "ok"
          next()
        .put (req, res, next) ->
          amount = parseInt(req.params.amount ?= 1) # default amount = 1
          antidote.defaultBucket = req.params.bucket
          integer = antidote.integer req.params.key
          response = await antidote.update integer.increment amount
          res.send "ok"
          next()

      router.route '/set/:bucket/:key/:value'
        .get (req, res, next) ->
          value = parseInt(req.params.value)
          antidote.defaultBucket = req.params.bucket
          integer = antidote.integer req.params.key
          response = await antidote.update integer.set value
          res.send "ok"
          next()
        .put (req, res, next) ->
          value = parseInt(req.params.value)
          antidote.defaultBucket = req.params.bucket
          integer = antidote.integer req.params.key
          response = await antidote.update integer.set value
          res.send "ok"
          next()

      return router
