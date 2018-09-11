## Deprecation Notice
The `integer` API has been removed from Antidote.
The implementation now uses the `counter` API to emulate it.

The API is here for legacy purposes (looks at @rogerpueyo).


    module.exports = (antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        integer = antidote.counter req.params.key
        value = await integer.read()
        res.send String value
        next()

      router.route '/increment/:bucket/:key/:amount?'
        .get (req, res, next) ->
          amount = parseInt(req.params.amount ?= 1) # default amount = 1
          antidote.defaultBucket = req.params.bucket
          integer = antidote.counter req.params.key
          response = await antidote.update integer.increment amount
          res.send "ok"
          next()
        .put (req, res, next) ->
          amount = parseInt(req.params.amount ?= 1) # default amount = 1
          antidote.defaultBucket = req.params.bucket
          integer = antidote.counter req.params.key
          response = await antidote.update integer.increment amount
          res.send "ok"
          next()

There is no `set` operation for counters, like there existed for integers.
We emulate it by first reding the counter value and subtracting that to the
new value being set and issuing an `increment` operation:

`counter := counter + (newValue - counter)`

      router.route '/set/:bucket/:key/:value'
        .get (req, res, next) ->
          antidote.defaultBucket = req.params.bucket
          integer = antidote.counter req.params.key
          value = parseInt(req.params.value) - await integer.read()
          response = await antidote.update integer.increment value
          res.send "ok"
          next()
        .put (req, res, next) ->
          antidote.defaultBucket = req.params.bucket
          integer = antidote.counter req.params.key
          value = parseInt(req.params.value) - await integer.read()
          response = await antidote.update integer.increment value
          res.send "ok"
          next()

      return router
