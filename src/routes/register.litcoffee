    module.exports = (webserver, antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        register = antidote.register req.params.key
        await register.read().then defer value
        res.send String value
        next()

      router.route '/set/:bucket/:key/:value'
        .get (req, res, next) ->
          value = String req.params.value
          antidote.defaultBucket = req.params.bucket
          register = antidote.register req.params.key
          await antidote.update(register.set(value)).then defer response
          res.send "ok"
          next()
        .put (req, res, next) ->
          value = String req.params.value
          antidote.defaultBucket = req.params.bucket
          register = antidote.register req.params.key
          await antidote.update(register.set(value)).then defer response
          res.send "ok"
          next()

      return router
