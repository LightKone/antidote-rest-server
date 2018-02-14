    module.exports = (antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        mvregister = antidote.multiValueRegister req.params.key
        value = await mvregister.read()
        res.send String value
        next()

      router.route '/set/:bucket/:key/:value'
        .get (req, res, next) ->
          value = String req.params.value
          antidote.defaultBucket = req.params.bucket
          mvregister = antidote.multiValueRegister req.params.key
          response = await antidote.update mvregister.set value
          res.send "ok"
          next()
        .put (req, res, next) ->
          value = String req.params.value
          antidote.defaultBucket = req.params.bucket
          mvregister = antidote.multiValueRegister req.params.key
          response = await antidote.update mvregister.set value
          res.send "ok"
          next()

      return router
